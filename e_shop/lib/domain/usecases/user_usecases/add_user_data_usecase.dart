import 'package:e_shop/domain/entities/user_entity.dart';
import 'package:e_shop/domain/repositories/firebase_user_repository.dart';

class AddUserDataUseCase {
  final FirebaseUserRepository repository;

  AddUserDataUseCase(this.repository);
  Future<void> call(UserEntity newUser) async {
    return await repository.addUserData(newUser);
  }
}
