import '../entities/user_entity.dart';
// import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseUserRepository {
  Future<UserEntity> getUserById(String uid);

  Future<void> addUserData(UserEntity newUser);

  Future<void> updateUserData(UserEntity updatedUser);

  // Stream<UserEntity> loggedUserStream(User loggedFirebaseUser);
}
