import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user_model.dart';
import 'firebase_user_remote_datasource.dart';

abstract class FirebaseAuthRemoteDatasource {
  Future<User> get loggedFirebaseUser;
  String get authException;

  Future<void> signUp(UserModel newUser, String password);

  Future<void> logInWithEmailAndPassword(String email, String password);

  Future<bool> isLoggedIn();

  Future<void> logOut();

  Future<void> sendPasswordResetEmail({required String email});
}

class FirebaseAuthRemoteDatasourceImpl implements FirebaseAuthRemoteDatasource {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUserRemoteDatasource _userDatasource =
      FirebaseUserRemoteDatasourceImpl();
  String _authException = "Authentication Failure";

  @override
  String get authException => _authException;

  @override
  Future<User> get loggedFirebaseUser async => _firebaseAuth.currentUser!;

  @override
  Future<bool> isLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var isUser =
          await _userDatasource.isExistInCollection(userCredential.user!.uid);
      if (!isUser) {
        await logOut();
      }
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut().catchError((error) => print(error));
  }

  @override
  Future<void> signUp(UserModel newUser, String password) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: newUser.email,
        password: password,
      );
      newUser = newUser.cloneWith(uid: userCredential.user!.uid);

      await _userDatasource.addUserData(newUser);
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }
}
