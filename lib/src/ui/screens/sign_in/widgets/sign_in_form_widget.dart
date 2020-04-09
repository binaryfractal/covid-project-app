import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/blocs/sign_in/sign_in_form_bloc.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/ui/screens/forgot_password/forgot_password_screen.dart';
import 'package:covidapp/src/ui/widgets/app_raised_rounded_button/app_raised_rounded_button_widget.dart';
import 'package:covidapp/src/ui/widgets/app_snack_bar/app_sback_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SignInFormWidget extends StatelessWidget {
  SignInFormWidget({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppSnackBarHandler appSnackBarHandler = AppSnackBarHandler(context);
    final SignInFormBloc signInFormBloc = BlocProvider.of<SignInFormBloc>(
        context);

    final double widthTextField = MediaQuery
        .of(context)
        .size
        .width / 6.0;
    final double heightSpace = ((MediaQuery
        .of(context)
        .size
        .height / 5.0) * 2.0) / 20.0;
    final double heightButton = ((MediaQuery
        .of(context)
        .size
        .height / 5.0) * 2.0) / 6.0;

    return Builder(
      builder: (context) {
        return FormBlocListener<SignInFormBloc, String, String>(
          onSubmitting: (context, state) {
            appSnackBarHandler.showSnackBar(AppSnackBarWidget.load(
              text: CustomLocalization.of(context).translate(
                  'sign_in_snackbar_loading'),
            ));
          },
          onSuccess: (context, state) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationEvent.AuthenticationLoggedIn);
            Navigator.of(context).pop();
          },
          onFailure: (context, state) {
            appSnackBarHandler.showSnackBar(AppSnackBarWidget.failure(
              text: CustomLocalization.of(context).translate(
                  state.failureResponse),
            ));
          },
          child: ListView(
            children: <Widget>[
              Form(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - widthTextField,
                      child: TextFieldBlocBuilder(
                        textFieldBloc: signInFormBloc.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: CustomLocalization.of(context).translate(
                              'sign_in_placeholder_email'),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - widthTextField,
                      child: TextFieldBlocBuilder(
                        textFieldBloc: signInFormBloc.password,
                        suffixButton: SuffixButton.obscureText,
                        decoration: InputDecoration(
                          labelText: CustomLocalization.of(context).translate(
                              'sign_in_placeholder_password'),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                    ),
                    SizedBox(height: heightSpace),
                    Container(
                      padding: EdgeInsets.only(right: (widthTextField / 2.0)),
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: Text(CustomLocalization.of(context).translate('sign_in_forgot_password'),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordScreen();
                              }));
                        },
                      ),
                    ),
                    SizedBox(height: heightSpace),
                    AppRaisedRoundedButtonWidget(
                      text: CustomLocalization.of(context).translate(
                          'sign_in_button_sign_in'),
                      height: heightButton,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - widthTextField,
                      onPressed: signInFormBloc.submit,
                    ),
                  ],
                ),
              ),
            ],
          )
        );
      },
    );
  }
}