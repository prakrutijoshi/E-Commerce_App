import '../datasources/remote_datasource/firebase_order_remote_datasource.dart';
import '../models/order_model.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/firebase_order_repository.dart';

class FirebaseOrderRepositoryImpl implements FirebaseOrderRepository {
  final FirebaseOrderRemoteDatasource remoteDatasource;

  FirebaseOrderRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<OrderEntity>> getOrders(String sid) async {
    List<OrderModel> orderModelList = await remoteDatasource.getOrders();

    List<OrderModel> neworderModelList = [];

    orderModelList.forEach((orderModel) {
      orderModel.orderedItems
          .removeWhere((orderedItem) => orderedItem.sellerId != sid);
      print(orderModel.orderedItems.length);

      if (orderModel.orderedItems.isNotEmpty) {
        neworderModelList.add(orderModel);
      }
    });
    return neworderModelList;
  }
}
