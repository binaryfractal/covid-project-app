import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaseChipWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double margin = MediaQuery.of(context).size.width / 40.0;

    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      child: Chip(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        avatar: Icon(
          Icons.warning,
          color: Colors.red,
        ),
        backgroundColor: HexColor('ffeea5'),
        label: Text(CustomLocalization.of(context).translate('home_chip_label_fase'),
          style: TextStyle(
            color: HexColor('bfaf6a'),
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}