import 'dart:async';
import 'dart:convert';

import 'package:covidapp/src/resources/localization/localization_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  final Locale _locale;

  LocalizationRepositoryImpl({@required Locale locale})
    : _locale = locale;

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString =
    await rootBundle.loadString('lang/${_locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}