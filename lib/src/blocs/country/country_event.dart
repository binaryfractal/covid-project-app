import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CountryEvent extends Equatable {
  const CountryEvent();
}

class CountryInitialized extends CountryEvent {
  @override
  String toString() => '$runtimeType';

  @override
  List<Object> get props => [];
}

class CountryLoaded extends CountryEvent {
  @override
  String toString() => '$runtimeType';

  @override
  List<Object> get props => [];
}