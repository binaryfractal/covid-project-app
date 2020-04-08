import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget({
    Key key,
    @required Size preferredSize,
    @required Profile profile,
  }) : super(
    key: key,
    preferredSize: preferredSize,
    child: _AppBarInternalWidget(size: preferredSize, profile: profile),
  );
}

class _AppBarInternalWidget extends StatelessWidget {
  final Size size;
  final Profile profile;

  _AppBarInternalWidget({ this.size, this.profile });

  @override
  Widget build(BuildContext context) {

    final double sizePieceAppBar = MediaQuery.of(context).size.width / 6.0;
    final double sizeImage = MediaQuery.of(context).size.width / 8.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(40.0),
            bottomRight: const Radius.circular(40.0)
        ),
      ),
      child: Column(
        children: <Widget>[
          SafeArea(
            top: true,
            child: Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: sizePieceAppBar,
                  height: size.height,
                  alignment: Alignment.centerRight,
                  child: RawMaterialButton(
                    child: SvgPicture.asset(
                      'assets/images/btn-menu.svg',
                      width: sizeImage,
                      height: sizeImage,
                    ),
                    shape: CircleBorder(),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                Container(
                  width: sizePieceAppBar * 3.5,
                  height: size.height,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(CustomLocalization.of(context).translate('app_name'),
                        style: TextStyle(
                          fontFamily: 'Avalon',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w900,
                          color: HexColor('6244b3'),
                        ),
                      ),
                      Text(CustomLocalization.of(context).translate('app_sub_name'))
                    ],
                  ),
                ),
                Container(
                  width: sizePieceAppBar * 1.5,
                  height: size.height,
                  alignment: Alignment.center,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.end,
                    children: <Widget>[
                      Text('${profile.idCountry}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.language,
                        color: Colors.grey,
                        size: 18.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}