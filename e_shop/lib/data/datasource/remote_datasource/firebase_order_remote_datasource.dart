import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/order_model.dart';

abstract class FirebaseOrderRemoteDatasource {
  Future<List<OrderModel>> getOrders(String uid);

  Future<void> addOrder(OrderModel newOrder);

  Future<void> removeOrder(OrderModel deleteOrder);
}

class FirebaseOrderRemoteDatasourceImpl
    implements FirebaseOrderRemoteDatasource {
  var _orderCollection = FirebaseFirestore.instance.collection("orders");

  @override
  Future<List<OrderModel>> getOrders(String uid) async {
    return await _orderCollection
        .where("uid", isEqualTo: uid)
        .get()
        .then((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList())
        .catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> addOrder(OrderModel newOrder) async {
    return await _orderCollection.doc(newOrder.oid).set(newOrder.toMap());
  }

  @override
  Future<void> removeOrder(OrderModel deleteOrder) async {
    return await _orderCollection.doc(deleteOrder.oid).delete();
  }
}
