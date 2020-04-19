
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository_impl.dart';
import 'package:covidapp/src/resources/country/country_repository.dart';
import 'package:covidapp/src/resources/country/country_repository_impl.dart';
import 'package:covidapp/src/resources/covid/covid_repository.dart';
import 'package:covidapp/src/resources/covid/covid_repository_impl.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/db/hive_repository_impl.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository_impl.dart';
import 'package:covidapp/src/resources/survey/survey_repository.dart';
import 'package:covidapp/src/resources/survey/survey_repository_impl.dart';
import 'package:covidapp/src/resources/version/version_repository.dart';
import 'package:covidapp/src/resources/version/version_repository_impl.dart';
import 'package:get_it/get_it.dart';

final GetIt repositoryLocator = GetIt.instance;

Future<void> setUpLocators() async {
  repositoryLocator.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl());
  repositoryLocator.registerSingleton<CovidRepository>(CovidRepositoryImpl());
  repositoryLocator.registerLazySingleton<DbRepository>(() =>
      HiveRepositoryImpl(db: DbKeys.covid_db));
  repositoryLocator.registerLazySingleton<ProfileRepository>(() =>
      ProfileRepositoryImpl(authenticationRepository: repositoryLocator.get<AuthenticationRepository>()));
  repositoryLocator.registerLazySingleton<CountryRepository>(() =>
      CountryRepositoryImpl(authenticationRepository: repositoryLocator.get<AuthenticationRepository>()));
  repositoryLocator.registerLazySingleton<SurveyRepository>(() =>
    SurveyRepositoryImpl(authenticationRepository: repositoryLocator.get<AuthenticationRepository>()));
  repositoryLocator.registerLazySingleton<VersionRepository>(() =>
      VersionRepositoryImpl(authenticationRepository: repositoryLocator.get<AuthenticationRepository>()));
}