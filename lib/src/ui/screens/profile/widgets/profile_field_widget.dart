import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ProfileFieldWidget extends StatelessWidget {
  final String label;
  final TextFieldBloc textFieldBloc;
  final TextInputType textInputType;

  ProfileFieldWidget({
    @required this.label,
    @required this.textFieldBloc,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFieldBlocBuilder(
        textFieldBloc: textFieldBloc,
        keyboardType: textInputType,

        decoration: InputDecoration(
          labelText: label
        ),
      )
    );
  }
}