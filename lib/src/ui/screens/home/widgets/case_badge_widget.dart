import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CaseBadgeWidget extends StatelessWidget {
  final Color iconColor;
  final String svgPath;
  final String text;
  final int value;

  CaseBadgeWidget({
    @required this.iconColor,
    @required this.svgPath,
    @required this.text,
    @required this.value
  });

  @override
  Widget build(BuildContext context) {
    final double widthBadge =
        (MediaQuery.of(context).size.width / 2.0) - (MediaQuery.of(context).size.width / 12.0);
    final double heightBadge = MediaQuery.of(context).size.height / 12.0;
    final double marginBadge = MediaQuery.of(context).size.width / 40.0;
    final double widthPieceBadge = widthBadge / 4.0;

    return Container(
      width: widthBadge,
      height: heightBadge,
      margin: EdgeInsets.all(marginBadge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: widthPieceBadge * 3.0,
                  child: Text(text,
                    style: TextStyle(
                      color: HexColor('c1bdc5'),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: widthPieceBadge * 0.5,
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.fiber_manual_record,
                    color: iconColor,
                    size: 12.0,
                  ),
                ),
              ],
            ),
          ),
          Text('$value',
            style: TextStyle(
              color:  HexColor('616161'),
              fontWeight: FontWeight.w800,
              fontSize: 24.0,
            ),
          ),
          SvgPicture.asset(
            'assets/images/linea.svg',
          )
        ],
      ),
    );
  }
}