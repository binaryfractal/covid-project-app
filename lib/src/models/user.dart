import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String country;
  final String state;
  final String gender;
  final int age;

  User(
      {@required this.id,
      @required this.email,
      this.name,
      this.country,
      this.state,
      this.gender,
      this.age});

  @override
  List<Object> get props => [id, email, name, country, state, gender, age];

  @override
  bool get stringify => true;
}
