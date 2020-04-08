import 'package:flutter/material.dart';

class AppRaisedRoundedButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double height;
  final double width;

  AppRaisedRoundedButtonWidget({
    @required this.text,
    @required this.onPressed,
    this.height = 32,
    this.width = 256,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Container(
        height: this.height,
        width: this.width,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}