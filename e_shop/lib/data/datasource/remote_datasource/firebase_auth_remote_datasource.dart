import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user_model.dart';
import 'firebase_user_remote_datasource.dart';

abstract class FirebaseAuthRemoteDatasource {
  Future<User> get loggedFirebaseUser;
  String get authException;

  Future<void> signUp(UserModel newUser, String password);

  Future<void> logInWithEmailAndPassword(String email, String password);

  Future<void> signInwithGoogle();

  Future<void> signOutFromGoogle();

  Future<bool> isLoggedIn();

  Future<void> logOut();

  Future<void> sendPasswordResetEmail({required String email});
}

class FirebaseAuthRemoteDatasourceImpl implements FirebaseAuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUserRemoteDatasource _userDatasource =
      FirebaseUserRemoteDatasourceImpl();
  String _authException = "Authentication Failure";
  UserModel newGoogleUser = UserModel(
      uid: "", email: "", name: "", avatar: "", phoneNumber: "", addresses: []);

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
  Future<void> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var userCredential = await _firebaseAuth.signInWithCredential(credential);

      var isUser =
          await _userDatasource.isExistInCollection(userCredential.user!.uid);
      if (!isUser) {
        newGoogleUser = newGoogleUser.cloneWith(
            uid: userCredential.user!.uid,
            name: userCredential.user!.displayName,
            avatar: userCredential.user!.photoURL ?? "",
            email: userCredential.user!.email,
            phoneNumber: userCredential.user!.phoneNumber ?? "");

        await _userDatasource.addUserData(newGoogleUser);
      }
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  @override
  Future<void> signOutFromGoogle() async {
    // ignore: invalid_return_type_for_catch_error
    await _googleSignIn.signOut().catchError((error) => print(error));
    await _firebaseAuth.signOut().catchError((error) => print(error));
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
