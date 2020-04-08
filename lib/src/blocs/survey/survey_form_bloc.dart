import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/models/answer.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/models/question.dart';
import 'package:covidapp/src/models/survey.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:covidapp/src/resources/survey/survey_repository.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SurveyFormBloc extends FormBloc<String, String> {
  final SurveyRepository _surveyRepository;
  final ProfileRepository _profileRepository;
  final AuthenticationRepository _authenticationRepository;
  final DbRepository _dbRepository;
  Survey _survey;

  SurveyFormBloc(
      {SurveyRepository surveyRepository, ProfileRepository profileRepository, AuthenticationRepository authenticationRepository, DbRepository dbRepository})
      : assert(surveyRepository != null),
        assert(profileRepository != null),
        assert(authenticationRepository != null),
        assert(dbRepository != null),
        _surveyRepository = surveyRepository,
        _profileRepository = profileRepository,
        _authenticationRepository = authenticationRepository,
        _dbRepository = dbRepository,
        super(isLoading: true);

  @override
  void onLoading() async {
    try {
      final List<Survey> surveys = await _getSurveys();
      _survey = surveys.first;
      final questions = _survey.questions.where((v) => v.subQuestion == null || !v.subQuestion);
      questions.forEach((question) {
        final fieldBloc = _buildFieldBloc(question);
        addFieldBloc(fieldBloc: fieldBloc);
        _addOnValueChanges(question, surveys, fieldBloc);
      });
      emitLoaded();
    } catch (e) {
      emitLoadFailed();
    }
  }

  @override
  void onSubmitting() async {
    try {
      // In the next version the cast is not necessary for get the value
      // But the types is for static analysis
      var fieldBlocs = state
          .fieldBlocs()
          .values
          .cast<SingleFieldBloc<Object, Object, FieldBlocState<Object, Object, Question>, Question>>();

      fieldBlocs = fieldBlocs.where((w) => w.value != null);
      final questionsWithAnswers = fieldBlocs.map((e) {
        if (e.value == null) return null;
        final values = _parseValueToList(e);
        if (values == null || values.isEmpty) return null;
        values.removeWhere((r) => r == null);
        return _buildQuestionFromAnswer(e, values);
      }).toList();
      final profile = await _buildProfile(questionsWithAnswers);
      final response = await _profileRepository.save(profile: profile);
      emitSuccess();
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }

  Future<Profile> _buildProfile(List<Question> questions) async {
    Profile hiveProfile = _dbRepository.get(DbKeys.profile);
    final surveys = List<Survey>()
      ..add(Survey(id: _survey.id,
          name: _survey.name,
          date: DateTime.now(),
          questions: questions));
    Profile profile = hiveProfile.copyWith(surveys: surveys);
    return profile;
  }

  Future<List<Survey>> _getSurveys() async {
    List<Survey> surveys = await _surveyRepository.findAll();
    return surveys;
  }

  void _addOnValueChanges(Question question, List<Survey> surveys, fieldBloc) {
    if (question.answers == null || question.answers.isEmpty)
      return;
    final subQuestions = question.answers.where((f) => f.idQuestion != null);
    if(subQuestions == null || subQuestions.isEmpty)
      return;
    Answer answer = subQuestions.first;
    Question subQuestion = surveys.first.questions
        .firstWhere((f) => f.id == answer.idQuestion);
    if (question.type == 'MULTIPLE') {
      // ignore: close_sinks
      final field = (fieldBloc as MultiSelectFieldBloc);
      field.onValueChanges(
        onData: (previous, current) async* {
          bool isPreviousContains = previous.value.toString().contains(answer.answer);
          bool isCurrentContains = current.value.toString().contains(answer.answer);
          if((isPreviousContains && isCurrentContains)
              || (!isPreviousContains && !isCurrentContains)){
            return;
          }
          final fieldBloc = _buildFieldBloc(subQuestion);
          if (subQuestion.answers != null && subQuestion.answers
              .where((f) => f.idQuestion != null)
              .length > 0)
            _addOnValueChanges(subQuestion, surveys, fieldBloc);
          if(!isPreviousContains && isCurrentContains){
            addFieldBloc(fieldBloc: fieldBloc);
            return;
          }
          removeFieldBloc(fieldBloc: fieldBloc);
        },
      );
    } else if (question.type == 'UNIQUE') {
      // ignore: close_sinks
      final field = (fieldBloc as SelectFieldBloc);
      field.onValueChanges(
        onData: (previous, current) async* {

          FieldBloc fieldBloc = _buildFieldBloc(subQuestion);
          if (subQuestion.answers != null && subQuestion.answers
              .where((f) => f.idQuestion != null)
              .length > 0)
            _addOnValueChanges(subQuestion, surveys, fieldBloc);
          if (current.value != null &&
              current.value.toString().contains(answer.answer)) {
            addFieldBloc(fieldBloc: fieldBloc);
          } else {
            removeFieldBloc(fieldBloc: fieldBloc);
          }
        },
      );
    }
  }

  Question _buildQuestionFromAnswer(SingleFieldBloc<Object, Object, FieldBlocState<Object, Object, Question>, Question> e, List<String> values) {
    final answer = (e.state.extraData.answers == null ||
        e.state.extraData.answers.isEmpty) ? _replaceBrackets(values) : null;
    List<Answer> answers = answer == null ? _getAnswers(e, values) : null;
    return Question(
      id: e.state.extraData.id,
      question: e.state.extraData.question,
      type: e.state.extraData.type,
      answer: answer,
      answers: answers,
    );
  }

  _buildFieldBloc(Question question) {
    if (question.type == 'FREE') {
      return _buildFree(question);
    } else if (question.type == 'MULTIPLE') {
      return _buildMultiple(question);
    } else if (question.type == 'UNIQUE') {
      return _buildUnique(question);
    }
    return null;
  }

  TextFieldBloc<Question> _buildFree(Question question) {
    return TextFieldBloc<Question>(
        name: question.question,
        extraData: question,
        validators: [FieldBlocValidators.required]);
  }

  MultiSelectFieldBloc _buildMultiple(Question question) {
    question.answers.removeWhere((e) => e == null || e.answer == null);
    question.answers.sort((a, b) => a.order.compareTo(b.order));
    final answers = question.answers.map((v) => v.answer).toList();
    return MultiSelectFieldBloc<String, Question>(
        items: answers,
        name: question.question,
        extraData: question,
        validators: [FieldBlocValidators.required]);
  }

  SelectFieldBloc _buildUnique(Question question) {
    question.answers.removeWhere((e) => e == null || e.answer == null);
    question.answers.sort((a, b) => a.order.compareTo(b.order));
    final answers = question.answers.map((v) => v.answer).toList();
    return SelectFieldBloc<String, Question>(
        name: question.question,
        extraData: question,
        items: answers,
        validators: [FieldBlocValidators.required]);
  }

  String _replaceBrackets(List<String> values) {
    return values.toString().replaceFirst("[", "").replaceFirst("]", "");
  }


  List<Answer> _getAnswers(SingleFieldBloc<Object, Object, FieldBlocState<Object, Object, Question>, Question> e, List<String> values) {
    final answers = e.state.extraData.answers
        .where((f) => values.contains(f.answer))
        .toList();
    return answers;
  }

  List<String> _parseValueToList(SingleFieldBloc<Object, Object, FieldBlocState<Object, Object, Question>, Question> e) {
    return e.value is Iterable
        ? (e.value as List<String>)
        : ((List<String>())
      ..add((e.value as String)
          .replaceFirst("[", "")
          .replaceFirst("]", "")));
  }
}
