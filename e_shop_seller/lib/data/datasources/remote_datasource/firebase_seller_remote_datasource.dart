import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/seller_model.dart';

abstract class FirebaseSellerRemoteDatasource {
  Future<SellerModel> getSellerById(String sid);

  Future<void> addSellerData(SellerModel newSeller);

  Future<void> updateSellerData(SellerModel updatedSeller);

  Future<bool> isExistInCollection(String sid);

  // Stream<SellerModel> loggedSellerStream(User loggedFirebaseSeller);
}

class FirebaseSellerRemoteDatasourceImpl
    implements FirebaseSellerRemoteDatasource {
  var _sellerCollection = FirebaseFirestore.instance.collection("sellers");

  @override
  Future<void> addSellerData(SellerModel newSeller) async {
    return await _sellerCollection
        .doc(newSeller.sid)
        .set(newSeller.toMap())
        .catchError((error) => print(error));
  }

  @override
  Future<SellerModel> getSellerById(String sid) async {
    return await _sellerCollection
        .doc(sid)
        .get()
        .then((doc) => SellerModel.fromMap(doc.data()!));
  }

  @override
  Future<void> updateSellerData(SellerModel updatedSeller) async {
    await _sellerCollection.doc(updatedSeller.sid).get().then((doc) async {
      if (doc.exists) {
        await doc.reference.update(updatedSeller.toMap());
      }
    });
  }

  @override
  Future<bool> isExistInCollection(String sid) async {
    return await _sellerCollection.doc(sid).get().then((doc) {
      if (doc.exists) {
        return true;
      } else {
        return false;
      }
    });
  }
}
