import 'dart:convert';
import 'dart:io';

import 'package:covidapp/src/core/api_url.dart';
import 'package:covidapp/src/models/country.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/country/country_repository.dart';
import 'package:http/http.dart' as http;

class CountryRepositoryImpl implements CountryRepository {
  final AuthenticationRepository _authenticationRepository;

  CountryRepositoryImpl({AuthenticationRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository;

  Future<List<Country>> findAll() async {
    final response = await http.get(
      await Url.get(ApiUrl.countries),
      headers: {
        HttpHeaders.authorizationHeader:
            await _authenticationRepository.getCurrentToken(),
      }
    );

    final responseJson = json.decode(response.body) as List;
    List<Country> countries = responseJson.map((model) => Country.fromJson(model)).toList();
    return countries;
  }

  Future<Country> findOne({String id}) async {
    final response = await http.get(
      '${await Url.get(ApiUrl.countries)}/$id',
      headers: {
        HttpHeaders.authorizationHeader:
            await _authenticationRepository.getCurrentToken(),
      }
    );

    final responseJson = json.decode(response.body);
    return Country.fromJson(responseJson);
  }
}