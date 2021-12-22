import 'package:e_shop/domain/entities/user_entity.dart';
import 'package:e_shop/domain/repositories/firebase_user_repository.dart';

class GetUserByIdUseCase {
  final FirebaseUserRepository repository;

  GetUserByIdUseCase(this.repository);
  Future<UserEntity> call(String uid) async {
    return await repository.getUserById(uid);
  }
}
