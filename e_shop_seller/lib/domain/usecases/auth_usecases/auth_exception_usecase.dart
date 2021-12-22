import '../../repositories/firebase_auth_repository.dart';

class AuthExceptionUseCase {
  final FirebaseAuthRepository repository;

  AuthExceptionUseCase(this.repository);

  String call() {
    return repository.authException;
  }
}
