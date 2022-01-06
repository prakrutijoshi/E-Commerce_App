import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/cart_item_model.dart';

abstract class FirebaseCartRemoteDatasource {
  Stream<List<CartItemModel>> fetchCart(String uid);

  Future<void> addCartItem(String uid, CartItemModel newCartItem);

  Future<void> removeCartItem(String uid, CartItemModel deleteCartItem);

  Future<void> clearCart(String uid);

  Future<void> updateCartItem(String uid, CartItemModel updateCartItem);
}

class FirebaseCartRemoteDatasourceImpl implements FirebaseCartRemoteDatasource {
  var _userCollection = FirebaseFirestore.instance.collection("users");

  @override
  Stream<List<CartItemModel>> fetchCart(String uid) {
    return _userCollection
        .doc(uid)
        .collection("cart")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CartItemModel.fromMap(doc.data()))
            .toList())
        .handleError((error) => print(error));
  }

  @override
  Future<void> addCartItem(String uid, CartItemModel newCartItem) async {
    await _userCollection
        .doc(uid)
        .collection("cart")
        .doc(newCartItem.cid)
        .get()
        .then((doc) async {
      if (doc.exists) {
        var quantity = int.parse(doc.data()!["quantity"]) +
            int.parse(newCartItem.quantity);
        var price =
            num.parse(doc.data()!["price"]) + num.parse(newCartItem.price);

        await doc.reference.update(
            {"quantity": quantity.toString(), "price": price.toString()});
      } else {
        await doc.reference.set(newCartItem.toMap());
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> removeCartItem(String uid, CartItemModel deleteCartItem) async {
    await _userCollection
        .doc(uid)
        .collection("cart")
        .doc(deleteCartItem.cid)
        .delete()
        .catchError((error) => print(error));
  }

  @override
  Future<void> clearCart(String uid) async {
    await _userCollection
        .doc(uid)
        .collection("cart")
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
  Future<void> updateCartItem(String uid, CartItemModel updateCartItem) async {
    await _userCollection
        .doc(uid)
        .collection("cart")
        .doc(updateCartItem.cid)
        .get()
        .then((doc) async {
      if (doc.exists) {
        await doc.reference.update(updateCartItem.toMap());
      }
    }).catchError((error) {
      print(error);
    });
  }
}
