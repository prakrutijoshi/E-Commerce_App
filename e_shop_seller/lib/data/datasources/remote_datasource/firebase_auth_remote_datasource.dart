import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/seller_model.dart';
import 'firebase_seller_remote_datasource.dart';

abstract class FirebaseAuthRemoteDatasource {
  Future<User> get loggedFirebaseSeller;
  String get authException;

  Future<void> signUp(SellerModel newSeller, String password);

  Future<void> logInWithEmailAndPassword(String email, String password);

  Future<void> signInwithGoogle();

  Future<void> signOutFromGoogle();

  Future<bool> isLoggedIn();

  Future<void> logOut();

  Future<void> sendPasswordResetEmail({required String email});
}

class FirebaseAuthRemoteDatasourceImpl implements FirebaseAuthRemoteDatasource {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseSellerRemoteDatasource _sellerDatasource =
      FirebaseSellerRemoteDatasourceImpl();
  String _authException = "Authentication Failure";
  SellerModel newGoogleSeller =
      SellerModel(sid: "", email: "", name: "", avatar: "", phoneNumber: "");

  @override
  String get authException => _authException;

  @override
  Future<User> get loggedFirebaseSeller async => _firebaseAuth.currentUser!;

  @override
  Future<bool> isLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      var sellerCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var isSeller = await _sellerDatasource
          .isExistInCollection(sellerCredential.user!.uid);
      if (!isSeller) {
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

      var sellerCredential =
          await _firebaseAuth.signInWithCredential(credential);

      var isSeller = await _sellerDatasource
          .isExistInCollection(sellerCredential.user!.uid);
      if (!isSeller) {
        newGoogleSeller = newGoogleSeller.cloneWith(
            sid: sellerCredential.user!.uid,
            name: sellerCredential.user!.displayName,
            avatar: sellerCredential.user!.photoURL ?? "",
            email: sellerCredential.user!.email,
            phoneNumber: sellerCredential.user!.phoneNumber ?? "");

        await _sellerDatasource.addSellerData(newGoogleSeller);
      }
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  @override
  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut().catchError((error) => print(error));
    await _firebaseAuth.signOut().catchError((error) => print(error));
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut().catchError((error) => print(error));
  }

  @override
  Future<void> signUp(SellerModel newSeller, String password) async {
    try {
      var sellerCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: newSeller.email,
        password: password,
      );
      newSeller = newSeller.cloneWith(sid: sellerCredential.user!.uid);

      await _sellerDatasource.addSellerData(newSeller);
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
