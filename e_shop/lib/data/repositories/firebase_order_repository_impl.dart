import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/firebase_order_repository.dart';
import '../datasource/remote_datasource/firebase_order_remote_datasource.dart';
import '../model/order_model.dart';

class FirebaseOrderRepositoryImpl implements FirebaseOrderRepository {
  final FirebaseOrderRemoteDatasource remoteDatasource;

  FirebaseOrderRepositoryImpl({required this.remoteDatasource});

  @override
  Future<void> addOrder(OrderEntity newOrder) async {
    return await remoteDatasource.addOrder(newOrder as OrderModel);
  }

  @override
  Future<List<OrderEntity>> getOrders(String uid) async {
    return await remoteDatasource.getOrders(uid);
  }

  @override
  Future<void> removeOrder(OrderEntity deleteOrder) async {
    return await remoteDatasource.removeOrder(deleteOrder as OrderModel);
  }
}
