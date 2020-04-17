import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppScaffoldWidget extends StatelessWidget {
  final Widget child;
  final Widget topChild;
  final Widget bottomChild;

  AppScaffoldWidget({
    @required this.child,
    this.topChild,
    this.bottomChild,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Spacer(),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                 child: topChild ?? _TopChild(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    //height: aspectRatio * 500,
                    child: Center(
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: bottomChild ?? _BottomChild(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SvgPicture.asset('assets/images/coronavirus.svg',
            width: 100,
            height: 100,
          ),
        ),
        Text(CustomLocalization.of(context).translate('app_name'),
          style: TextStyle(
            fontFamily: 'Avalon',
            color: HexColor('5839ae'),
            fontSize: 28.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(CustomLocalization.of(context).translate('app_sub_name'),
            style: TextStyle(
              fontFamily: 'Avalon',
              color: HexColor('5839ae'),
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SvgPicture.asset('assets/images/coronavirus-bottom.svg',
          allowDrawingOutsideViewBox: true,
        ),
      ),
    );
  }
}