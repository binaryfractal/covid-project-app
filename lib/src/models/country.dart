import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Country extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String nameApi;
  @HiveField(3)
  final int confirmed;
  @HiveField(4)
  final int recovered;
  @HiveField(5)
  final int risk;
  @HiveField(6)
  final int riskFree;
  @HiveField(7)
  final int riskHigh;
  @HiveField(8)
  final int riskLow;
  @HiveField(9)
  final int total;
  @HiveField(10)
  final int deaths;

  Country(
      {this.id,
        this.name,
        this.nameApi,
        this.confirmed,
        this.recovered,
        this.risk,
        this.riskFree,
        this.riskHigh,
        this.riskLow,
        this.total,
        this.deaths,
      });

  @override
  List<Object> get props => [
    id,
    name,
    nameApi,
    confirmed,
    recovered,
    risk,
    riskFree,
    riskHigh,
    riskLow,
    total,
    deaths,
  ];

  Country copyWith({
    String id,
    String name,
    String nameApi,
    int confirmed,
    int recovered,
    int risk,
    int riskFree,
    int riskHigh,
    int riskLow,
    int total,
    int deaths,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      nameApi: nameApi ?? this.nameApi,
      confirmed: confirmed ?? this.confirmed,
      recovered: recovered ?? this.recovered,
      risk: risk ?? this.risk,
      riskFree: riskFree ?? this.riskFree,
      riskHigh: riskHigh ?? this.riskHigh,
      riskLow: riskLow ?? this.riskLow,
      total: total ?? this.total,
      deaths: deaths ?? this.deaths,
    );
  }

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  bool get stringify => true;
}
