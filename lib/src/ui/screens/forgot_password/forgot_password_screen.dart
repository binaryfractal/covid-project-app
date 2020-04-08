import 'package:covidapp/src/blocs/forgot_password/forgot_password_form_bloc.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/ui/screens/forgot_password/widgets/forgot_password_form_widget.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends  StatelessWidget {
  ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      child: BlocProvider(
        create: (context) => ForgotPasswordFormBloc(
            authenticationRepository: repositoryLocator.get<AuthenticationRepository>()
        ),
        child: ForgotPasswordFormWidget(),
      ),
    );
  }
}