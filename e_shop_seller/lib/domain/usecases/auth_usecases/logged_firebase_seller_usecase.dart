import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/firebase_auth_repository.dart';

class LoggedFirebaseSellerUseCase {
  final FirebaseAuthRepository repository;

  LoggedFirebaseSellerUseCase(this.repository);

  Future<User> call() async {
    return await repository.loggedFirebaseSeller;
  }
}
