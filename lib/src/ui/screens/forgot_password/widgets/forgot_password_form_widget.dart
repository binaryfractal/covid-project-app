import 'package:covidapp/src/blocs/forgot_password/forgot_password_form_bloc.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/ui/widgets/app_raised_rounded_button/app_raised_rounded_button_widget.dart';
import 'package:covidapp/src/ui/widgets/app_snack_bar/app_sback_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ForgotPasswordFormWidget extends StatelessWidget {
  ForgotPasswordFormWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppSnackBarHandler appSnackBarHandler = AppSnackBarHandler(context);
    final ForgotPasswordFormBloc forgotPasswordFormBloc = BlocProvider.of<ForgotPasswordFormBloc>(context);

    final double widthTextField = MediaQuery.of(context).size.width / 6.0;
    final double heightSpace = ((MediaQuery.of(context).size.height / 5.0) * 2.0) / 18.0;
    final double heightButton = ((MediaQuery.of(context).size.height / 5.0) * 2.0) / 6.0;
    final double sizeContainer = MediaQuery.of(context).size.width - widthTextField;

    return Builder(
      builder: (context) {
        return FormBlocListener<ForgotPasswordFormBloc, String, String>(
          onSubmitting: (context, state) {
            appSnackBarHandler.showSnackBar(AppSnackBarWidget.load(
              text: CustomLocalization.of(context).translate(
                  'forgot_password_snackbar_loading'),
            ));
          },
          onSuccess: (context, state) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(CustomLocalization.of(context).translate(
                    'forgot_password_dialog_title'),
                  ),
                  content: Text(CustomLocalization.of(context).translate(
                      'forgot_password_dialog_content'),
                  ),
                );
              }
            );
          },
          onFailure: (context, state) {
            appSnackBarHandler.showSnackBar(AppSnackBarWidget.failure(
              text: CustomLocalization.of(context).translate(
                  state.failureResponse),
            ));
          },
          child: Form(
            child: Column(
              children: <Widget>[
                Container(
                  width: sizeContainer,
                  child: TextFieldBlocBuilder(
                    textFieldBloc: forgotPasswordFormBloc.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: CustomLocalization.of(context).translate(
                          'forgot_password_placeholder_email'),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                SizedBox(height: heightSpace),
                AppRaisedRoundedButtonWidget(
                  text: CustomLocalization.of(context).translate(
                      'forgot_password_button_access_recover'),
                  height: heightButton,
                  width: sizeContainer,
                  onPressed: forgotPasswordFormBloc.submit,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}