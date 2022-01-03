import 'package:firebase_auth/firebase_auth.dart';

import '../entities/user_entity.dart';

abstract class FirebaseAuthRepository {
  Future<User> get loggedFirebaseUser;
  String get authException;

  Future<void> signUp(UserEntity newUser, String password);

  Future<void> logInWithEmailAndPassword(String email, String password);

  Future<void> signInwithGoogle();

  Future<void> signOutFromGoogle();

  Future<bool> isLoggedIn();

  Future<void> logOut();

  Future<void> sendPasswordResetEmail({required String email});
}
