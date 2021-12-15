import '../../entities/user_entity.dart';
import '../../repositories/firebase_auth_repository.dart';

class SignUpUseCase {
  final FirebaseAuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call(UserEntity newUser, String password) async {
    await repository.signUp(newUser, password);
  }
}
