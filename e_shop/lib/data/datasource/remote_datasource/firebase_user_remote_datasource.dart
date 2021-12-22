import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/user_model.dart';

abstract class FirebaseUserRemoteDatasource {
  Future<UserModel> getUserById(String uid);

  Future<void> addUserData(UserModel newUser);

  Future<void> updateUserData(UserModel updatedUser);

  Future<bool> isExistInCollection(String uid);

  // Stream<UserModel> loggedUserStream(User loggedFirebaseUser);
}

class FirebaseUserRemoteDatasourceImpl implements FirebaseUserRemoteDatasource {
  var _userCollection = FirebaseFirestore.instance.collection("users");

  @override
  Future<void> addUserData(UserModel newUser) async {
    return await _userCollection
        .doc(newUser.uid)
        .set(newUser.toMap())
        .catchError((error) => print(error));
  }

  @override
  Future<UserModel> getUserById(String uid) async {
    return await _userCollection
        .doc(uid)
        .get()
        .then((doc) => UserModel.fromMap(doc.data()!))
        .catchError((error) => print(error));
  }

  @override
  Future<void> updateUserData(UserModel updatedUser) async {
    await _userCollection.doc(updatedUser.uid).get().then((doc) async {
      if (doc.exists) {
        // update
        await doc.reference.update(updatedUser.toMap());
      }
    }).catchError((error) => print(error));
  }

  @override
  Future<bool> isExistInCollection(String uid) async {
    return await _userCollection.doc(uid).get().then((doc) {
      if (doc.exists) {
        return true;
      } else {
        return false;
      }
    });
  }
}
