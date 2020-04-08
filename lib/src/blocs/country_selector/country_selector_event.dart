import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CountrySelectorEvent extends Equatable {
  const CountrySelectorEvent();
}

class CountrySelectorInitialized extends CountrySelectorEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType';
}

class CountrySelectorLoaded extends CountrySelectorEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType';
}

class CountrySelectorSelected extends CountrySelectorEvent {
  final String countryCode;

  CountrySelectorSelected(this.countryCode);

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType { country: $countryCode}';
}