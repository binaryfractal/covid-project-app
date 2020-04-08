import 'package:covidapp/src/models/survey.dart';

abstract class SurveyRepository {
  Future<List<Survey>> findAll();
}
