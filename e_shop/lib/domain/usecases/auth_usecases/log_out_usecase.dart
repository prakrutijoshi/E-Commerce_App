import '../../repositories/firebase_auth_repository.dart';

class LogOutUseCase {
  final FirebaseAuthRepository repository;

  LogOutUseCase(this.repository);

  Future<void> call() async {
    await repository.logOut();
  }
}
