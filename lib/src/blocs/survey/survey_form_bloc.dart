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
      final topQuestions = _survey.questions.where((v) =>
      v.subQuestion == null || !v.subQuestion);
      for (int i = 0; i < topQuestions.length; i++) {
        final question = topQuestions.toList()[i];
        final fieldBloc = _buildFieldBloc(question);
        final ids = question.answers.map((a) => a.idQuestion).toSet()
          ..removeWhere((v) => v == null);
        final fieldBlocs = List<FieldBloc>();
        final questions = List<Question>();
        questions.add(question);
        fieldBlocs.add(fieldBloc);
        if (ids == null || ids.isEmpty) {
          addFieldBloc(fieldBloc: fieldBloc, step: i);
        } else {
          final subQuestion = _survey.questions
              .where((v) => ids.contains(v.id))
              .toList()
              .first;
          final subFieldBloc = _buildFieldBloc(subQuestion);
          fieldBlocs.add(subFieldBloc);
          addFieldBlocs(step: i, fieldBlocs: fieldBlocs);
          removeFieldBloc(fieldBloc: subFieldBloc);
          questions.add(subQuestion);
        }
        _addOnValueChanges(questions, surveys, fieldBlocs, i);
      }
      emitLoaded();
    } catch (e) {
      print(e);
      emitLoadFailed();
    }
  }

  void _addOnValueChanges(List<Question> questions, List<Survey> surveys, List<FieldBloc> fieldBlocs, int step) {
    if (questions == null || questions.isEmpty)
      return;
    final subAnswers = questions[0].answers.where((f) => f.idQuestion != null);
    if(subAnswers == null || subAnswers.isEmpty)
      return;
    Answer answer = subAnswers.first;
    Question subQuestion = surveys.first.questions
        .firstWhere((f) => f.id == answer.idQuestion);
    if (questions[0].type == 'MULTIPLE') {
      // ignore: close_sinks
      final field = (fieldBlocs[0] as MultiSelectFieldBloc);
      field.onValueChanges(
        onData: (previous, current) async* {
          bool isPreviousContains = previous.value.toString().contains(answer.answer);
          bool isCurrentContains = current.value.toString().contains(answer.answer);
          if((isPreviousContains && isCurrentContains)
              || (!isPreviousContains && !isCurrentContains)){
            return;
          }
          final fieldBloc = fieldBlocs[1];
          if(!isPreviousContains && isCurrentContains){
            addFieldBloc(fieldBloc: fieldBloc, step: step);
          } else {
            removeFieldBloc(fieldBloc: fieldBloc);
          }
        },
      );
    } else if (questions[0].type == 'UNIQUE') {
      // ignore: close_sinks
      final field = (fieldBlocs[0] as SelectFieldBloc);
      field.onValueChanges(
        onData: (previous, current) async* {
          FieldBloc fieldBloc = fieldBlocs[1];
          if (current.value != null &&
              current.value.toString().contains(answer.answer)) {
            addFieldBloc(fieldBloc: fieldBloc, step: step);
          } else {
            removeFieldBloc(fieldBloc: fieldBloc);
          }
        },
      );
    }
  }

  @override
  void onSubmitting() async {
    try {
      // In the next version the cast is not necessary for get the value
      // But the types is for static analysis
      if(state.currentStep < state.numberOfSteps-1){
        emitSuccess();
        return;
      }
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
      print("questionsWithAnswers: $questionsWithAnswers");
      final profile = await _buildProfile(questionsWithAnswers);
      final response = await _profileRepository.save(profile: profile);
      emitSuccess();
    } catch (e) {
      print(e);
      emitFailure(failureResponse: e.toString());
    }
  }

  Future<Profile> _buildProfile(List<Question> questions) async {
    Profile hiveProfile = _dbRepository.get(DbKeys.profile.toString());
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

