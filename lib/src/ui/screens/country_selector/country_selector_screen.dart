import 'package:covidapp/src/blocs/country_selector/country_selector_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/resources/country/country_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/screens/country_selector/widgets/country_picker_widget.dart';
import 'package:covidapp/src/ui/screens/profile/profile_screen.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:covidapp/src/ui/widgets/app_snack_bar/app_sback_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class CountrySelectorScreen extends StatelessWidget {
  final Profile _profile;

  CountrySelectorScreen({
    Key key,
    @required Profile profile,
  })  : _profile = profile,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double heightTopAndBottom = MediaQuery.of(context).size.height / 5.0;

    return AppScaffoldWidget(
      child: BlocProvider<CountrySelectorBloc>(
        create: (context) => CountrySelectorBloc(
          countryRepository: repositoryLocator.get<CountryRepository>(),
          dbRepository: repositoryLocator.get<DbRepository>(),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                CustomLocalization.of(context).translate('country_selector_title'),
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              _CountrySelector(
                profile: _profile,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CountrySelector extends StatelessWidget {
  final Profile _profile;

  _CountrySelector({
    @required Profile profile,
  }) : _profile = profile;

  @override
  Widget build(BuildContext context) {
    final CountrySelectorBloc countrySelectorBloc = BlocProvider.of<CountrySelectorBloc>(context);
    countrySelectorBloc.add(CountrySelectorInitialized());

    return BlocListener<CountrySelectorBloc, CountrySelectorState>(
      listener: (context, state) {
        if(state is CountrySelectorSelectSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ProfileScreen(profile: _profile);
            }),
          );
        }

        AppSnackBarHandler appSnackBarHandler = AppSnackBarHandler(context);

        if(state is CountrySelectorLoadFailure) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.failure(
              text: CustomLocalization.of(context).translate('country_selector_snackbar_failure_1'),
          ));
        }

        if(state is CountrySelectorSelectInProgress) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.load(
              text: CustomLocalization.of(context).translate('country_selector_snackbar_loading'),
          ));
        }

        if(state is CountrySelectorSelectFailure) {
          appSnackBarHandler.showSnackBar(AppSnackBarWidget.failure(
              text: CustomLocalization.of(context).translate('country_selector_snackbar_failure_2')
          ));
        }
      },
      child: BlocBuilder<CountrySelectorBloc, CountrySelectorState>(
        builder: (context, state) {
          if (state is CountrySelectorLoadInProgress ||
              state is CountrySelectorInitial ||
              state is CountrySelectorSelectInProgress ||
              state is CountrySelectorSelectSuccess) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is CountrySelectorLoadSuccess) {
            return CountryPickerWidget(countriesCode: state.countries);
          }

          return Text('Something went wrong');
        },
      ),
    );
  }
}
