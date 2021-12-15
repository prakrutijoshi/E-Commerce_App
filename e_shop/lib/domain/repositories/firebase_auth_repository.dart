import '../entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRepository {
  Future<User> get loggedFirebaseUser;
  String get authException;

  Future<void> signUp(UserEntity newUser, String password);

  Future<void> logInWithEmailAndPassword(String email, String password);

  Future<bool> isLoggedIn();

  Future<void> logOut();
}
