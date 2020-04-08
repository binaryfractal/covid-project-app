import 'dart:convert';
import 'dart:io';

import 'package:covidapp/src/core/api_url.dart';
import 'package:covidapp/src/models/filter.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:http/http.dart' as http;

class ProfileRepositoryImpl implements ProfileRepository {
  final AuthenticationRepository _authenticationRepository;

  ProfileRepositoryImpl({AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  Future<Profile> findOne({String uid}) async {
    final response = await http.get(
      await Url.get(ApiUrl.profiles),
      headers: {
        HttpHeaders.authorizationHeader:
          await _authenticationRepository.getCurrentToken(),
      }
    );
    final responseJson = json.decode(response.body);
    return Profile.fromJson(responseJson);
  }

  @override
  Future save({Profile profile}) async {
    final response = await http.post(
      await Url.get(ApiUrl.profiles),
      headers: {
        HttpHeaders.authorizationHeader:
            await _authenticationRepository.getCurrentToken(),
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      },
      body: '{"profile":${jsonEncode(profile)}}',
    );
    final responseJson = json.decode(response.body);
    return responseJson;
  }

  @override
  Future<List<Profile>> findBy({List<Filter> filters}) async {
    final response = await http.post(
      await Url.get(ApiUrl.searches),
      headers: {
        HttpHeaders.authorizationHeader:
            await _authenticationRepository.getCurrentToken(),
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      },
      body: '{"filters":${jsonEncode(filters)}}',
    );

    final responseJson = json.decode(response.body) as List;
    List<Profile> profiles =
        responseJson.map((model) => Profile.fromJson(model)).toList();
    return profiles;
  }
}
