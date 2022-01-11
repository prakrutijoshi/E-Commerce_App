import '../entities/order_entity.dart';

abstract class FirebaseOrderRepository {
  Future<List<OrderEntity>> getOrders(String uid);

  Future<void> addOrder(OrderEntity newOrder);

  Future<void> removeOrder(OrderEntity deleteOrder);
}
