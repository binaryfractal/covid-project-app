import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/models/risk.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/screens/home/home_screen.dart';
import 'package:covidapp/src/ui/widgets/app_raised_rounded_button/app_raised_rounded_button_widget.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:covidapp/src/ui/widgets/global.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SurveySuccessWidget extends StatelessWidget {
  final Risk _risk;
  final DbRepository _dbRepository;

  SurveySuccessWidget({Risk risk, DbRepository dbRepository})
    : _risk = risk, _dbRepository = dbRepository;

  @override
  Widget build(BuildContext context) {
    final double spaceHeight = ((MediaQuery
        .of(context)
        .size
        .height / 5.0) * 2.0) / 18.0;
    final double spaceWidth = MediaQuery
        .of(context)
        .size
        .width / 8.0;
    final double widthButton = MediaQuery.of(context).size.width - spaceWidth * 2;
    final double heightButton = ((MediaQuery
        .of(context)
        .size
        .height / 5.0) * 2.0) / 6.0;

    return AppScaffoldWidget(
      topChild: Container(
        padding: EdgeInsets.symmetric(vertical: spaceWidth * 2),
        child: Text(_risk.name,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(_getImage()),
          SizedBox(height: spaceHeight),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spaceWidth),
            child: Text(
              _risk.message,
              style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      bottomChild: AppRaisedRoundedButtonWidget(
        height: heightButton,
        width: widthButton,
        text: "Terminar",
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return HomeScreen(
                  profile: _dbRepository.get(DbKeys.profile.toString()),
                );
              })
          );
        },
      ),
    );
  }

  String _getImage() {
    String riskImage = 'assets/images/';
    if(_risk.id == globals.confirmed)
      riskImage += globals.confirmed_img;
    else if(_risk.id == globals.recovered)
      riskImage += globals.recovered_img;
    else if(_risk.id == globals.risk_free)
      riskImage += globals.risk_free_img;
    else if(_risk.id == globals.risk_low)
      riskImage += globals.risk_low_img;
    else if(_risk.id == globals.risk)
      riskImage += globals.risk_img;
    else if(_risk.id == globals.risk_high)
      riskImage += globals.risk_high_img;

    return riskImage;
  }
}