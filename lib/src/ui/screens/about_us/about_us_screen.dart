import 'package:covidapp/src/core/custom_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(title: Text(
          CustomLocalization.of(context).translate(
                'about_us_title'),
        )),
        body: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              _AboutUsText(),
              SizedBox(height: 20.0),
              _Team(),
            ],
          ),
        )
    );
  }
}

class _AboutUsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String aboutUsText = CustomLocalization.of(context).translate('about_us_text');

    return Column(
      children: <Widget>[
        Text(CustomLocalization.of(context).translate('about_us_subtitle'),
          style: TextStyle(
            fontFamily: 'Avalon',
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
          child: Text(aboutUsText,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
            ),
          ),
        ),
      ],
    );
  }
}

class _Team extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(CustomLocalization.of(context).translate('about_us_subtitle_team'),
          style: TextStyle(
            fontFamily: 'Avalon',
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
          child: Column(
            children: <Widget>[
              _CardTeam(
                name: CustomLocalization.of(context).translate('about_us_team_name_1'),
                description: CustomLocalization.of(context).translate('about_us_team_description_1'),
                onPressed: () async {
                  const url = 'https://binaryfractal.com/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw '${CustomLocalization.of(context).translate('about_us_team_url_error')} $url';
                  }
                },
                leading: Image.asset('assets/images/binaryfractal.png'),
              ),
              SizedBox(height: 10.0),
              _CardTeam(
                name: CustomLocalization.of(context).translate('about_us_team_name_2'),
                description: CustomLocalization.of(context).translate('about_us_team_description_2'),
                onPressed: () async {
                  const url = 'https://binaryfractal.com/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw '${CustomLocalization.of(context).translate('about_us_team_url_error')} $url';
                  }
                },
                leading: Image.asset('assets/images/binaryfractal.png'),
              ),
              SizedBox(height: 10.0),
              _CardTeam(
                name: CustomLocalization.of(context).translate('about_us_team_name_3'),
                description: CustomLocalization.of(context).translate('about_us_team_description_3'),
                onPressed: () async {
                  const url = 'http://www.designmel.com/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw '${CustomLocalization.of(context).translate('about_us_team_url_error')} $url';
                  }
                },
                leading: Image.asset('assets/images/designmel.jpg'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardTeam extends StatelessWidget {
  final String name;
  final String description;
  final Function onPressed;
  final Widget leading;

  _CardTeam({  this.name, this.description, this.onPressed, this.leading });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: leading,
                title: Text(name),
                subtitle: Text(description),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text(CustomLocalization.of(context).translate('about_us_team_more'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: onPressed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}