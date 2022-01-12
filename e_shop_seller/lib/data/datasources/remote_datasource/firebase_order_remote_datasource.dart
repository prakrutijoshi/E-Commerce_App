import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/order_model.dart';

abstract class FirebaseOrderRemoteDatasource {
  Future<List<OrderModel>> getOrders();
}

class FirebaseOrderRemoteDatasourceImpl
    implements FirebaseOrderRemoteDatasource {
  var _orderCollection = FirebaseFirestore.instance.collection("orders");

  @override
  Future<List<OrderModel>> getOrders() async {
    return await _orderCollection
        .get()
        .then((snapshot) => snapshot.docs.map((doc) {
              return OrderModel.fromMap(doc.data());
            }).toList())
        .catchError((error) {
      print(error);
    });
  }
}
