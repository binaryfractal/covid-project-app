import 'package:covidapp/src/models/country.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CountrySelectorState extends Equatable {
  const CountrySelectorState();
}

class CountrySelectorInitial extends CountrySelectorState {
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType';
}

class CountrySelectorLoadInProgress extends CountrySelectorState {
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType';
}

class CountrySelectorLoadSuccess extends CountrySelectorState {
  final List<String> countries;

  CountrySelectorLoadSuccess({@required this.countries});

  @override
  List<Object> get props => [countries];

  @override
  String toString() => '$runtimeType { countries $countries }';
}

class  CountrySelectorLoadFailure extends CountrySelectorState {
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType';
}

class CountrySelectorSelectSuccess extends CountrySelectorState {
  final Country country;

  CountrySelectorSelectSuccess({this.country});

  @override
  List<Object> get props => [country];

  @override
  String toString() => '$runtimeType { country: $country }';
}

class CountrySelectorSelectInProgress extends CountrySelectorState {
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType';
}

class  CountrySelectorSelectFailure extends CountrySelectorState {
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType';
}

