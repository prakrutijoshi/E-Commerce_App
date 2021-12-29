import 'package:firebase_auth/firebase_auth.dart';

import '../../models/seller_model.dart';
import 'firebase_seller_remote_datasource.dart';

abstract class FirebaseAuthRemoteDatasource {
  Future<User> get loggedFirebaseSeller;
  String get authException;

  Future<void> signUp(SellerModel newSeller, String password);

  Future<void> logInWithEmailAndPassword(String email, String password);

  Future<bool> isLoggedIn();

  Future<void> logOut();

  Future<void> sendPasswordResetEmail({required String email});
}

class FirebaseAuthRemoteDatasourceImpl implements FirebaseAuthRemoteDatasource {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseSellerRemoteDatasource _sellerDatasource =
      FirebaseSellerRemoteDatasourceImpl();
  String _authException = "Authentication Failure";

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
