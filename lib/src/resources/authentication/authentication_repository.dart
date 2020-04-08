import 'package:covidapp/src/models/user.dart';

abstract class AuthenticationRepository {
  Future<void> signIn({String email, String password});

  Future<void> signUp({String email, String password});

  Future<void> forgotPassword({String email});

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<User> getCurrentUser();

  Future<String> getCurrentToken();
}