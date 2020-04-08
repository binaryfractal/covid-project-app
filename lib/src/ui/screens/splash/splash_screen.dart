import 'package:covidapp/src/ui/widgets/app_scaffold/app_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}