import '../datasource/remote_datasource/firebase_user_remote_datasource.dart';
import '../model/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/firebase_user_repository.dart';

class FirebaseUserRepositoryImpl implements FirebaseUserRepository {
  final FirebaseUserRemoteDatasource remoteDatasource;

  FirebaseUserRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> addUserData(UserEntity newUser) async {
    return await remoteDatasource.addUserData(newUser as UserModel);
  }

  @override
  Future<UserEntity> getUserById(String uid) async {
    return await remoteDatasource.getUserById(uid);
  }

  @override
  Future<void> updateUserData(UserEntity updatedUser) async {
    return await remoteDatasource.updateUserData(updatedUser as UserModel);
  }
}
