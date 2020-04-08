import 'package:covidapp/src/blocs/profile/profile_form_bloc.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:covidapp/src/ui/screens/profile/widgets/profile_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ProfileScreen extends StatelessWidget {
  final Profile _profile;

  ProfileScreen({
    Key key,
    @required Profile profile,
  })  : _profile = profile,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _profile.name.isNotEmpty ? AppBar(title: Text(
          CustomLocalization.of(context).translate('profile_app_bar'))) : null,
      body: BlocProvider(
        create: (context) => ProfileFormBloc(
          authenticationRepository:  repositoryLocator.get<AuthenticationRepository>(),
          profileRepository: repositoryLocator.get<ProfileRepository>(),
          dbRepository: repositoryLocator.get<DbRepository>(),
          profile: _profile,
        ),
        child: ProfileFormWidget(
          profile: _profile,
        ),
      ),
    );
  }
}
