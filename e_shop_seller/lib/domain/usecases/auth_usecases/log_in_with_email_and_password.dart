import '../../repositories/firebase_auth_repository.dart';

class LogInWithEmailAndPasswordUseCase {
  final FirebaseAuthRepository repository;

  LogInWithEmailAndPasswordUseCase(this.repository);

  Future<void> call(String email, String password) async {
    return await repository.logInWithEmailAndPassword(email, password);
  }
}
