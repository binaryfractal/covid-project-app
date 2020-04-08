import 'package:flutter/material.dart';

class LegalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(title: Text('Aviso de Privacidad')),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Aviso de Privacidad',
                style: TextStyle(
                  fontFamily: 'Avalon',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
    );
  }
}