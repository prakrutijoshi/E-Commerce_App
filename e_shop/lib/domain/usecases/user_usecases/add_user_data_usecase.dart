import '../../entities/user_entity.dart';
import '../../repositories/firebase_user_repository.dart';

class AddUserDataUseCase {
  final FirebaseUserRepository repository;

  AddUserDataUseCase(this.repository);
  Future<void> call(UserEntity newUser) async {
    return await repository.addUserData(newUser);
  }
}
