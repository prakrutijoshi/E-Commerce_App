import '../../repositories/firebase_auth_repository.dart';

class IsLoggedInUseCase {
  final FirebaseAuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}
