import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/screens/country_selector/country_selector_screen.dart';
import 'package:covidapp/src/ui/screens/home/home_screen.dart';
import 'package:covidapp/src/ui/screens/splash/splash_screen.dart';
import 'package:covidapp/src/ui/screens/welcome/welcome_screen.dart';
import 'package:covidapp/src/ui/widgets/global.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {

  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Futura',
          brightness: Brightness.light,
          primaryColor: globals.primaryColor,
          buttonColor: globals.primaryColor,
          accentColor: globals.primaryColor,
          indicatorColor: globals.secondaryColor,
          backgroundColor: globals.secondaryColor,
          textTheme: TextTheme(
            body1: TextStyle(color: Color(0xff6345B4)),
          ),
        ),
        supportedLocales: [Locale('es', 'MX'), Locale('en', 'US')],
        localizationsDelegates: [
          CustomLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationInitial) {
              return SplashScreen();
            }

            if (state is AuthenticationFailure) {
              return WelcomeScreen();
            }

            if (state is AuthenticationSuccess) {
              if (_isFirstTime()) {
                return CountrySelectorScreen(
                  profile: state.profile,
                );
              } else {
                return HomeScreen(
                  profile: state.profile,
                );
              }
            }
            return SplashScreen();
          },
        ),
      );
  }

  bool _isFirstTime() {
    DbRepository dbRepository = repositoryLocator.get<DbRepository>();
    Profile profile = dbRepository.get(DbKeys.profile);
    if(profile.name != null) {
      return false;
    }
    return true;
  }
}
