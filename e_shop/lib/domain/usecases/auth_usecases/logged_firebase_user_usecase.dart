import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/firebase_auth_repository.dart';

class LoggedFirebaseUserUseCase {
  final FirebaseAuthRepository repository;

  LoggedFirebaseUserUseCase(this.repository);

  Future<User> call() async {
    return await repository.loggedFirebaseUser;
  }
}
