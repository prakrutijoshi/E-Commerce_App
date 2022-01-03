import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/firebase_auth_repository.dart';
import '../datasource/remote_datasource/firebase_auth_remote_datasource.dart';
import '../model/user_model.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthRemoteDatasource remoteDatasource;

  FirebaseAuthRepositoryImpl(this.remoteDatasource);

  @override
  String get authException => remoteDatasource.authException;

  @override
  Future<User> get loggedFirebaseUser async =>
      await remoteDatasource.loggedFirebaseUser;

  @override
  Future<bool> isLoggedIn() async {
    return await remoteDatasource.isLoggedIn();
  }

  @override
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    return await remoteDatasource.logInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signInwithGoogle() async {
    return await remoteDatasource.signInwithGoogle();
  }

  @override
  Future<void> signOutFromGoogle() async {
    await remoteDatasource.signOutFromGoogle();
  }

  @override
  Future<void> logOut() async {
    await remoteDatasource.logOut();
  }

  @override
  Future<void> signUp(UserEntity newUser, String password) async {
    await remoteDatasource.signUp(newUser as UserModel, password);
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    return await remoteDatasource.sendPasswordResetEmail(email: email);
  }
}
