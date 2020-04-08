import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/models/country.dart';
import 'package:covidapp/src/ui/screens/home/widgets/case_badge_widget.dart';
import 'package:flutter/material.dart';

class CasesWidget extends StatelessWidget {
  final Country country;

  CasesWidget({@required this.country});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(this.country.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Center(
            child: Wrap(
              children: <Widget>[
                CaseBadgeWidget(
                  iconColor: Colors.red,
                  svgPath: 'assets/images/infected.svg',
                  text: CustomLocalization.of(context).translate('home_label_total_cases'),
                  value: this.country.total,
                ),
                CaseBadgeWidget(
                  iconColor: Colors.orange,
                  svgPath: 'assets/images/person.svg',
                  text: CustomLocalization.of(context).translate('home_label_active_cases'),
                  value: this.country.confirmed,
                ),
                CaseBadgeWidget(
                  iconColor: Colors.green,
                  svgPath: 'assets/images/person.svg',
                  text: CustomLocalization.of(context).translate('home_label_recovered'),
                  value: this.country.recovered,
                ),
                CaseBadgeWidget(
                  iconColor: Colors.black,
                  svgPath: 'assets/images/person.svg',
                  text: CustomLocalization.of(context).translate('home_label_deaths'),
                  value: this.country.deaths,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}