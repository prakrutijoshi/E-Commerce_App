import 'package:e_shop/data/datasource/remote_datasource/firebase_user_remote_datasource.dart';
import 'package:e_shop/data/model/user_model.dart';
import 'package:e_shop/domain/entities/user_entity.dart';
import 'package:e_shop/domain/repositories/firebase_user_repository.dart';

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
