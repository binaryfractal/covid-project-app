import 'package:flutter/material.dart';

class AppSnackBarWidget extends SnackBar {
  AppSnackBarWidget(
      {Key key,
      @required String text,
      @required Color backgroundColor,
      IconData iconData})
      : assert(content != null),
        super(
            key: key,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text(text), Icon(iconData)],
            ),
            backgroundColor: backgroundColor, duration: Duration(seconds: 30));

  AppSnackBarWidget.success({Key key, @required String text})
      : assert(content == null),
        super(
            key: key,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text(text), Icon(Icons.check)],
            ),
            backgroundColor: Colors.green[300]);

  AppSnackBarWidget.failure({Key key, @required String text})
      : assert(content == null),
        super(
            key: key,
            content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(text), Icon(Icons.error)],
              ),
            ),
            backgroundColor: Colors.red[300]);

  AppSnackBarWidget.load({Key key, String text})
      : assert(content == null),
        super(
            key: key,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text(text), CircularProgressIndicator()],
            ),
            backgroundColor: Colors.blue[300]);
}

class AppSnackBarHandler {
  final BuildContext context;

  AppSnackBarHandler(this.context);

  void showSnackBar(SnackBar snackBar) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}