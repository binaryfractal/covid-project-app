import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckupsWidgets extends StatelessWidget {
  static ScrollController scrollController = ScrollController();
  final List<Profile> profiles;

  CheckupsWidgets({@required this.profiles});

  @override
  Widget build(BuildContext context) {
    if(profiles.length > 0) {
      return Container(
        height: 180.0 * profiles.length,
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          controller: scrollController,
          itemCount: profiles.length,
          itemBuilder: (context, index) => _CheckupCardWidget(profile: profiles[index]),
        ),
      );
    } else {
      final double height = MediaQuery.of(context).size.height / 2;
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        height: height,
        child: Text(CustomLocalization.of(context).translate('home_label_without_registers'),
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      );
    }
  }
}

class _CheckupCardWidget extends StatelessWidget {
  final Profile profile;

  _CheckupCardWidget({@required this.profile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.red[600],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text('${DateFormat('dd/MM/yyyy').format(profile.lastUpdate)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text('${profile.state}, ${profile.town}',
                      style: TextStyle(
                        color: HexColor('f6eeff'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(CustomLocalization.of(context).translate('home_card_label_gender'),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: HexColor('f6eeff'),
                          ),
                        ),
                        Text('${profile.gender},',
                          style: TextStyle(
                            color: HexColor('f6eeff'),
                          ),
                        ),
                        Text(CustomLocalization.of(context).translate('home_card_label_age_1'),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: HexColor('f6eeff'),
                          ),
                        ),
                        Text('${profile.age} ',
                          style: TextStyle(
                            color: HexColor('f6eeff'),
                          ),
                        ),
                        Text(CustomLocalization.of(context).translate('home_card_label_age_2'),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: HexColor('f6eeff'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text(CustomLocalization.of(context).translate('home_card_more'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}