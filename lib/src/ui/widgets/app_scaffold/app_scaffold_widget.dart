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
    final double heightTopAndBottom = MediaQuery.of(context).size.height / 5.0;
    final double heightMain = heightTopAndBottom * 2.3;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              topChild ?? _TopChild(),
              Container(
                height: heightMain,
                child: Center(
                  child: child,
                ),
              ),
              bottomChild ?? _BottomChild(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double heightTop = (MediaQuery.of(context).size.height / 5.0) * 1.7;
    final double heightTopPadding = MediaQuery.of(context).size.height / 10.0;

    return Container(
      padding: EdgeInsets.only(top: heightTopPadding),
      height: heightTop,
      child: Column(
        children: <Widget>[
          SvgPicture.asset('assets/images/coronavirus.svg',
            width: 100,
            height: 100,
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
      ),
    );
  }
}

class _BottomChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double heightBottom = MediaQuery.of(context).size.height / 5.0;

    return Container(
      height: heightBottom,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SvgPicture.asset('assets/images/coronavirus-bottom.svg',
          width: MediaQuery.of(context).size.width,
          height: heightBottom / 1.3,
          allowDrawingOutsideViewBox: true,
        ),
      ),
    );
  }
}