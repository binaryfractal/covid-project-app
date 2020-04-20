import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/version/version_repository.dart';
import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Version extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => _showDialog(context));
    return AppScaffoldWidget(child: null);
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Text(
                      CustomLocalization.of(context).translate('version_title'),
                      style: Theme.of(context).textTheme.subtitle),
                ),
                Icon(Icons.system_update)
              ],
            ),
            content: Text(
              CustomLocalization.of(context).translate('version_content'),
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 18),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  CustomLocalization.of(context).translate('version_ok'),
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () => _buildUrl(context),
              )
            ],
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
      ),
      barrierDismissible: false,
    );
  }

  Future _buildUrl(BuildContext context) async {
    const url = 'https://covid.binaryfractal.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '${CustomLocalization.of(context).translate('about_us_team_url_error')} $url';
    }
  }

  static Future<bool> isValidVersion() async {
    DbRepository dbRepository = repositoryLocator.get<DbRepository>();
    final appVersion = dbRepository.get(DbKeys.version);
    VersionRepository versionRepository =
        repositoryLocator.get<VersionRepository>();
    final currentVersion = await versionRepository.getCurrentVersion();
    if (appVersion == null || currentVersion.compareTo(appVersion) != 0) {
      return false;
    }
    return true;
  }
}
