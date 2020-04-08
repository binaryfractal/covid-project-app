import 'package:covidapp/src/models/survey.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(includeIfNull: false)
class Profile extends Equatable {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final num age;
  @HiveField(3)
  final String idCountry;
  @HiveField(4)
  final String country;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final String gender;
  @HiveField(7)
  final String idRisk;
  @HiveField(8)
  final String risk;
  @HiveField(9)
  final String state;
  @HiveField(10)
  final String town;
  @HiveField(11)
  final String zip;
  @HiveField(12)
  final DateTime firstUpdate;
  @HiveField(13)
  final DateTime lastUpdate;
  @HiveField(14)
  final List<Survey> surveys;

  Profile(
      {@required this.uid,
      this.name,
      this.age,
      this.idCountry,
      this.country,
      this.email,
      this.gender,
      this.idRisk,
      this.risk,
      this.state,
      this.town,
      this.zip,
      this.firstUpdate,
      this.lastUpdate,
      this.surveys});

  @override
  List<Object> get props => [
        uid,
        name,
        age,
        idCountry,
        country,
        email,
        gender,
        idRisk,
        risk,
        state,
        town,
        zip,
        firstUpdate,
        lastUpdate
      ];

  Profile copyWith({
    String uid,
    String name,
    num age,
    String idCountry,
    String country,
    String email,
    String gender,
    String idRisk,
    String risk,
    String state,
    String town,
    String zip,
    List<Survey> surveys,
  }) {
    return Profile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      age: age ?? this.age,
      idCountry: idCountry ?? this.idCountry,
      country: country ?? this.country,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      idRisk: idRisk ?? this.idRisk,
      risk: risk ?? this.risk,
      state: state ?? this.state,
      town: town ?? this.town,
      zip: zip ?? this.zip,
      firstUpdate: this.firstUpdate,
      lastUpdate: this.lastUpdate,
      surveys: surveys ?? this.surveys,
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  bool get stringify => true;
}
