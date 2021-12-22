import 'package:e_shop/domain/entities/user_entity.dart';
import 'package:e_shop/domain/repositories/firebase_user_repository.dart';

class UpdateUserDataUseCase {
  final FirebaseUserRepository repository;

  UpdateUserDataUseCase(this.repository);
  Future<void> call(UserEntity updatedUser) async {
    return await repository.updateUserData(updatedUser);
  }
}
