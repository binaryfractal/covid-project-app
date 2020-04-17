import 'package:covidapp/src/blocs/country/country_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/models/country.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/resources/country/country_repository.dart';
import 'package:covidapp/src/resources/covid/covid_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:covidapp/src/ui/screens/home/widgets/cases_widget.dart';
import 'package:covidapp/src/ui/screens/home/widgets/checkups_widgets.dart';
import 'package:covidapp/src/ui/screens/home/widgets/fase_chip_widget.dart';
import 'package:covidapp/src/ui/screens/survey/survey_screen.dart';
import 'package:covidapp/src/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:covidapp/src/ui/widgets/app_drawer/app_drawer_widget.dart';
import 'package:covidapp/src/ui/widgets/app_snack_bar/app_sback_bar_widget.dart';
import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  final Profile _profile;

  HomeScreen({
    Key key,
    @required Profile profile,
  })  : _profile = profile,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double heightAppBar = MediaQuery.of(context).size.height / 10.0;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBarWidget(
          preferredSize: Size.fromHeight(heightAppBar),
          profile: _profile,
        ),
        drawer: AppDrawerWidget(
          profile: _profile,
        ),
        floatingActionButton: _FloatingActionButtonCheckUp(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: BlocProvider<CountryBloc>(
          create: (context) => CountryBloc(
            covidRepository: repositoryLocator.get<CovidRepository>(),
            profileRepository: repositoryLocator.get<ProfileRepository>(),
            countryRepository: repositoryLocator.get<CountryRepository>(),
            dbRepository: repositoryLocator.get<DbRepository>(),
          ),
          child: _Home(),
        ),
      ),
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CountryBloc countryBloc = BlocProvider.of<CountryBloc>(context);
    countryBloc.add(CountryInitialized());

    return BlocListener<CountryBloc, CountryState>(
      listener: (context, state) {
        AppSnackBarHandler appSnackBarHandler = AppSnackBarHandler(context);

        if(state is CountryLoadFailure) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.failure(
              text: CustomLocalization.of(context).translate('home_snackbar_failure'),
          ));
        }
      },
      child: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if(state is CountryLoadInProgress) {
            return Center(
                child: CircularProgressIndicator()
            );
          }

          if(state is CountryLoadSuccess) {
            return ListView(
              children: <Widget>[
                _HomeTopScreen(country: state.country),
                _HomeBottomScreen(profiles: state.profiles),
                Container(
                  height: MediaQuery.of(context).size.height / 12,
                  decoration: BoxDecoration(
                    color: HexColor('f6eeff')
                  ),
                )
              ],
            );
          }

          return Text('Something went wrong');
        },
      ),
    );
  }
}

class _HomeTopScreen extends StatelessWidget {
  final Country country;

  _HomeTopScreen({@required this.country});

  @override
  Widget build(BuildContext context) {
    final DateTime dateNow = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(dateNow);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/wallpaper-home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          CasesWidget(country: country),
          FaseChipWidget(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('${CustomLocalization.of(context).translate('home_label_last_update')} $formattedDate',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingActionButtonCheckUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: FloatingActionButton.extended(
        elevation: 10.0,
        label: Text(CustomLocalization.of(context).translate('home_button_checkup'), style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        )),
        icon: Icon(Icons.playlist_add_check, color:  Colors.white),
        backgroundColor: HexColor('5839ae'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) {
                  return SurveyScreen();
                }
            )
          );
        },
      ),
    );
  }
}

class _HomeBottomScreen extends StatelessWidget {
  final List<Profile> profiles;

  _HomeBottomScreen({@required this.profiles});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: HexColor('f6eeff'),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(CustomLocalization.of(context).translate('home_label_last_confirmed'),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          CheckupsWidgets(profiles: profiles),
        ],
      ),
    );
  }
}