import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/wishlist_item_model.dart';

abstract class FirebaseWishlistRemoteDatasource {
  Stream<List<WishListItemModel>> fetchWishList(String uid);

  Future<void> addWishListItem(String uid, WishListItemModel newWishListItem);

  Future<void> removeWishListItem(
      String uid, WishListItemModel deleteWishListItem);

  Future<void> clearWishList(String uid);

  Future<bool> isExistsInWishList(String uid, String productId);
}

class FirebaseWishListRemoteDatasourceImpl
    implements FirebaseWishlistRemoteDatasource {
  var _userCollection = FirebaseFirestore.instance.collection("users");

  @override
  Stream<List<WishListItemModel>> fetchWishList(String uid) {
    return _userCollection
        .doc(uid)
        .collection("wishlist")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WishListItemModel.fromMap(doc.data()))
            .toList())
        .handleError((error) => print(error));
  }

  @override
  Future<void> addWishListItem(
      String uid, WishListItemModel newWishListItem) async {
    await _userCollection
        .doc(uid)
        .collection("wishlist")
        .doc(newWishListItem.wid)
        .get()
        .then((doc) async {
      if (doc.exists) {
        // var price =
        //   num.parse(doc.data()!["price"]);

        // await doc.reference.update({"price": price.toString()});
      } else {
        await doc.reference.set(newWishListItem.toMap());
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> removeWishListItem(
      String uid, WishListItemModel deleteWishListItem) async {
    await _userCollection
        .doc(uid)
        .collection("wishlist")
        .doc(deleteWishListItem.wid)
        .delete()
        .catchError((error) => print(error));
  }

  @override
  Future<void> clearWishList(String uid) async {
    await _userCollection
        .doc(uid)
        .collection("wishlist")
        .get()
        .then((snapshot) async {
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<bool> isExistsInWishList(String uid, String productId) async {
    return await _userCollection
        .doc(uid)
        .collection("wishlist")
        .doc(productId)
        .get()
        .then((doc) {
      if (doc.exists) {
        return true;
      } else {
        return false;
      }
    });
  }
}
