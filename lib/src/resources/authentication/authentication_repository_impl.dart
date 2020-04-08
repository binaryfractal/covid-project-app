import 'package:covidapp/src/models/user.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepositoryImpl({
    FirebaseAuth firebaseAuth
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signIn({String email, String password}) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<void> forgotPassword({String email}) async {
    return await _firebaseAuth.sendPasswordResetEmail(
      email: email
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<User> getCurrentUser() async {
    final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    final User user = User(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName
    );

    return user;
  }

  Future<String> getCurrentToken() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final String token = await user.getIdToken();

    return 'Bearer $token';    
  }

}