import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/ui/screens/sign_in/sign_in_screen.dart';
import 'package:covidapp/src/ui/screens/sign_up/sign_up_screen.dart';
import 'package:covidapp/src/ui/widgets/app_raised_rounded_button/app_raised_rounded_button_widget.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double heightButton = ((MediaQuery.of(context).size.height / 5.0) * 2.0) / 6.0;
    final double heightSpace = ((MediaQuery.of(context).size.height / 5.0) * 2.0) / 6.0;

    return AppScaffoldWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppRaisedRoundedButtonWidget(
              text: CustomLocalization.of(context).translate('wellcome_button_sign_in'),
              height: heightButton,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return SignInScreen();
                    }));
              }
          ),
          SizedBox(height: heightSpace),
          AppRaisedRoundedButtonWidget(
              text: CustomLocalization.of(context).translate('wellcome_button_sign_up'),
              height: heightButton,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    }));
              }
          ),
        ],
      ),
    );
  }
}