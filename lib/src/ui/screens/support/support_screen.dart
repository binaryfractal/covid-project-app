import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/ui/widgets/app_snack_bar/app_sback_bar_widget.dart';
import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text(
          CustomLocalization.of(context).translate('support_app_bar'))),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            _SupportText(
              title: CustomLocalization.of(context).translate('support_title'),
              text: CustomLocalization.of(context).translate('support_description'),
            ),
            SizedBox(height: 20.0),
            _SupportBuyCoffee(),
            SizedBox(height: 20.0),
            _SupportText(text: CustomLocalization.of(context).translate('support_label_other_option')),
            SizedBox(height: 20.0),
            _SupportQrBtc(),
            SizedBox(height: 20.0),
            _SupportWalletBtc(),
            SizedBox(height: 30.0),
          ],
        ),
      )
    );
  }
}

class _SupportText extends StatelessWidget {
  final String title;
  final String text;

  _SupportText({ this.title, this.text });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        title != null ?
        Text(CustomLocalization.of(context).translate('support_title'),
          style: TextStyle(
            fontFamily: 'Avalon',
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ) : Container(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
          child: Text(text,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class _SupportBuyCoffee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double widthPieceScreen = MediaQuery.of(context).size.width / 6.0;
    final double widthContainer = MediaQuery.of(context).size.width - (widthPieceScreen  * 3);

    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              const url = 'https://www.buymeacoffee.com/covidapp';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw '${CustomLocalization.of(context).translate('about_us_team_url_error')} $url';
              }
            },
            child: SvgPicture.asset('assets/images/i-buymeacoffee.svg',
              width: widthContainer,
              height: widthContainer,
            ),
          ),
          SizedBox(height: 20.0),
          Text(CustomLocalization.of(context).translate('support_label_buy_coffe'),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      )
    );
  }
}

class _SupportQrBtc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double widthPieceScreen = MediaQuery.of(context).size.width / 6.0;
    final double widthContainer = MediaQuery.of(context).size.width - (widthPieceScreen  * 2);

    return Container(
      width: widthContainer,
      height: widthContainer,
      child: Image.asset('assets/images/qr-btc.png'),
    );
  }
}

class _SupportWalletBtc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double widthPieceScreen = MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / 6.0);
    final double heightButton = ((MediaQuery.of(context).size.height / 5.0) * 3.0) / 6.0;

    return Container(
      height: heightButton,
      width: widthPieceScreen,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        color: HexColor('cab8fa'),
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Center(
                child: Text('1MCFrgvGdpD28EKz7DYDWA8LoLDTt2vTCf',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
            ),
          ),
        ),
        onPressed: () {
          ClipboardManager.copyToClipBoard('1MCFrgvGdpD28EKz7DYDWA8LoLDTt2vTCf')
              .then((result) {
            AppSnackBarHandler appSnackBarHandler = AppSnackBarHandler(context);

            appSnackBarHandler.showSnackBar(AppSnackBarWidget.success(
              text: CustomLocalization.of(context).translate('support_snackbar_copy_address'),
            ));
          });
        },
      ),
    );
  }
}