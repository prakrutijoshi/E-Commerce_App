import 'package:e_shop/domain/repositories/firebase_auth_repository.dart';

class LogInWithGoogleUseCase {
  final FirebaseAuthRepository repository;

  LogInWithGoogleUseCase(this.repository);

  Future<void> call() async {
    return await repository.signInwithGoogle();
  }
}
