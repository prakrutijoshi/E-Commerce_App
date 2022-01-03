import 'package:e_shop/domain/repositories/firebase_auth_repository.dart';

class LogOutFromGoogleUseCase {
  final FirebaseAuthRepository repository;

  LogOutFromGoogleUseCase(this.repository);

  Future<void> call() async {
    await repository.signOutFromGoogle();
  }
}
