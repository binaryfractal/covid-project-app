import 'dart:convert';
import 'dart:io';

import 'package:covidapp/src/core/api_url.dart';
import 'package:covidapp/src/models/survey.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/survey/survey_repository.dart';
import 'package:http/http.dart' as http;

class SurveyRepositoryImpl implements SurveyRepository {
  final AuthenticationRepository _authenticationRepository;

  SurveyRepositoryImpl({AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository;

  @override
  Future<List<Survey>> findAll() async {
    final response = await http.get(
      await Url.get(ApiUrl.surveys),
      headers: {
        HttpHeaders.authorizationHeader:
          await _authenticationRepository.getCurrentToken(),
      }
    );
    final responseJson = json.decode(response.body) as List;
    List<Survey> surveys =
        responseJson.map((model) => Survey.fromJson(model)).toList();
    return surveys;
  }
}
