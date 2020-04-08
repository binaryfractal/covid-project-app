import 'package:covidapp/src/resources/localization/localization_repository.dart';
import 'package:covidapp/src/resources/localization/localization_repository_impl.dart';
import 'package:flutter/material.dart';

class CustomLocalization {
  final LocalizationRepository localizationRepository;

  CustomLocalization(Locale locale)
      : localizationRepository = LocalizationRepositoryImpl(locale: locale);

  Future<bool> load() => localizationRepository.load();

  String translate(String key) => localizationRepository.translate(key);

  static const LocalizationsDelegate<CustomLocalization> delegate =
  _CustomLocalizationDelegate();

  static CustomLocalization of(BuildContext context) {
    return Localizations.of<CustomLocalization>(context, CustomLocalization);
  }
}

class _CustomLocalizationDelegate extends LocalizationsDelegate<CustomLocalization>{
  const _CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['es'].contains(locale.languageCode);
  }

  @override
  Future<CustomLocalization> load(Locale locale) async {
    CustomLocalization customLocalization = CustomLocalization(locale);
    await customLocalization.load();
    return customLocalization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<CustomLocalization> old) => false;
}