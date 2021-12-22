import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/seller_entity.dart';
import '../../domain/repositories/firebase_auth_repository.dart';
import '../datasources/remote_datasource/firebase_auth_remote_datasource.dart';
import '../models/seller_model.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthRemoteDatasource remoteDatasource;

  FirebaseAuthRepositoryImpl(this.remoteDatasource);

  @override
  String get authException => remoteDatasource.authException;

  @override
  Future<User> get loggedFirebaseSeller async =>
      await remoteDatasource.loggedFirebaseSeller;

  @override
  Future<bool> isLoggedIn() async {
    return await remoteDatasource.isLoggedIn();
  }

  @override
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    return await remoteDatasource.logInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> logOut() async {
    await remoteDatasource.logOut();
  }

  @override
  Future<void> signUp(SellerEntity newSeller, String password) async {
    await remoteDatasource.signUp(newSeller as SellerModel, password);
  }
}
