import 'package:covidapp/src/models/risk.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/widgets/app_raised_rounded_button/app_raised_rounded_button_widget.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:covidapp/src/ui/widgets/global.dart' as globals;
import 'package:flutter/cupertino.dart';
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
    final double widthButton = MediaQuery.of(context).size.width - (spaceWidth * 4);
    final double heightButton = ((MediaQuery
        .of(context)
        .size
        .height / 5.0) * 2.0) / 6.0;

    return AppScaffoldWidget(
      topChild: Container(
        child: Text(_risk.name.toUpperCase(),
          style: Theme
              .of(context)
              .textTheme
              .subtitle
              .copyWith(fontSize: 32.0),
          textAlign: TextAlign.center,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(child: SvgPicture.asset(_getImage())),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spaceWidth),
              child: Text(
                _risk.message,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.aspectRatio * 45,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
      bottomChild: Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: AppRaisedRoundedButtonWidget(
          height: heightButton,
          width: widthButton,
          text: "TERMINAR",
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
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