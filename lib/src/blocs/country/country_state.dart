import 'package:covidapp/src/models/country.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CountryState extends Equatable {
  const CountryState();
}

class CountryInitial extends CountryState {
  const CountryInitial();

  @override
  String toString() => '$runtimeType';

  @override
  List<Object> get props => [];
}

class CountryLoadInProgress extends CountryState {
  const CountryLoadInProgress();

  @override
  String toString() => '$runtimeType';

  @override
  List<Object> get props => [];
}

class CountryLoadSuccess extends CountryState {
  final Country country;
  final List<Profile> profiles;

  const CountryLoadSuccess({ this.country, this.profiles });

  @override
  String toString() => '$runtimeType { country: $country, profiles: $profiles }';

  @override
  List<Object> get props => [country, profiles];
}

class CountryLoadFailure extends CountryState {
  const CountryLoadFailure();

  @override
  String toString() => '$runtimeType';

  @override
  List<Object> get props => [];
}
