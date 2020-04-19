import 'package:bloc/bloc.dart';
import 'package:covidapp/src/app.dart';
import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/blocs/base_bloc_delegate.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/models/answer.dart';
import 'package:covidapp/src/models/country.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/models/question.dart';
import 'package:covidapp/src/models/survey.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Hive.initFlutter();
  Hive.registerAdapter(CountryAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(SurveyAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(AnswerAdapter());
  await Hive.openBox(DbKeys.covid_db)
    ..delete(DbKeys.last_update)
    ..put(DbKeys.version, "1.0.0");

  BlocSupervisor.delegate = BaseBlocDelegate();

  await setUpLocators();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) =>
        AuthenticationBloc(
            authenticationRepository: repositoryLocator.get<AuthenticationRepository>(),
            profileRepository: repositoryLocator.get<ProfileRepository>(),
            dbRepository: repositoryLocator.get<DbRepository>(),
        )
        ..add(AuthenticationEvent.AuthenticationAppStarted),
      child: App(),
    ),
  );
}
