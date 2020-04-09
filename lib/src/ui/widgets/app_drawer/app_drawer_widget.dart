import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/ui/screens/about_us/about_us_screen.dart';
import 'package:covidapp/src/ui/screens/legal/legal_screen.dart';
import 'package:covidapp/src/ui/screens/profile/profile_screen.dart';
import 'package:covidapp/src/ui/screens/support/support_screen.dart';
import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDrawerWidget extends StatelessWidget {
  final Profile _profile;

  AppDrawerWidget({
    Key key,
    Profile profile,
  })  : _profile = profile,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _AppDrawerHeader(profile: _profile),
          _AppDrawerListTile(
            icon: Icons.account_circle,
            text: CustomLocalization.of(context).translate('drawer_profile'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return ProfileScreen(
                      profile: _profile,
                    );
                  })
              );
            },
          ),
          _AppDrawerListTile(
            icon: Icons.location_on,
            text: CustomLocalization.of(context).translate('drawer_country'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _AppDrawerListTile(
            icon: Icons.monetization_on,
            text: CustomLocalization.of(context).translate('drawer_support'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return SupportScreen();
                })
              );
            },
          ),
          _AppDrawerListTile(
            icon: Icons.contact_mail,
            text: CustomLocalization.of(context).translate('drawer_about_us'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return AboutUsScreen();
                  })
              );
            },
          ),
          _AppDrawerListTile(
            icon: Icons.assignment,
            text: CustomLocalization.of(context).translate('drawer_legal'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return LegalScreen();
                  })
              );
            },
          ),
          _AppDrawerListTile(
            icon: Icons.redo,
            text: CustomLocalization.of(context).translate('drawer_sign_out'),
            onTap: () => {
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationEvent.AuthenticationLoggedOut,
              )
            },
          ),
        ],
      ),
    );
  }
}

class _AppDrawerHeader extends StatelessWidget {
  final Profile profile;

  _AppDrawerHeader({ Key key, this.profile })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: HexColor('6345b4'),
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              profile.gender == 'Male' ? 'assets/images/man.svg' : 'assets/images/woman.svg',
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('¡ ${CustomLocalization.of(context).translate('drawer_header_greeting')} ${profile.name} !',
                style: TextStyle(
                  color: HexColor('f6eeff'),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppDrawerListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  _AppDrawerListTile({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onTap
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: HexColor('6345b4'))),
        ),
        child: InkWell(
          splashColor: Colors.amberAccent,
          onTap: onTap,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon,
                      color: HexColor('6345b4'),
                    ),
                    Padding (
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right,
                  color: HexColor('6345b4'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}