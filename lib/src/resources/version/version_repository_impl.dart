import 'dart:io';

import 'package:covidapp/src/core/api_url.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/version/version_repository.dart';
import 'package:http/http.dart' as http;

class VersionRepositoryImpl implements VersionRepository {
  final AuthenticationRepository _authenticationRepository;

  VersionRepositoryImpl({AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository;

  @override
  Future getCurrentVersion() async {
    final response = await http.get(await Url.get(ApiUrl.versions), headers: {
      HttpHeaders.authorizationHeader:
          await _authenticationRepository.getCurrentToken(),
    });
    return response.body;
  }
}
