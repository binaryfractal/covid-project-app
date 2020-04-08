import 'package:covidapp/src/models/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  String toString() => '$runtimeType';

  @override
  List<Object> get props => [];
}

class AuthenticationFailure extends AuthenticationState {
  @override
  String toString() => '$runtimeType';

  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final Profile profile;

  AuthenticationSuccess(this.profile);

  @override
  String toString() => '$runtimeType { profile: $profile }';

  @override
  List<Object> get props => [profile];
}