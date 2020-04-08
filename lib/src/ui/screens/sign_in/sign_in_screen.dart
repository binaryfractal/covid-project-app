import 'package:covidapp/src/blocs/sign_in/sign_in_form_bloc.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/ui/screens/sign_in/widgets/sign_in_form_widget.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignInScreen extends StatelessWidget {
  SignInScreen({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      child: BlocProvider(
        create: (context) => SignInFormBloc(
          authenticationRepository: repositoryLocator.get<AuthenticationRepository>()
        ),
        child: SignInFormWidget(),
      ),
    );
  }
}