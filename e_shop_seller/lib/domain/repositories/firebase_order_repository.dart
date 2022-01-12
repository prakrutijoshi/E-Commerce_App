import '../entities/order_entity.dart';

abstract class FirebaseOrderRepository {
  Future<List<OrderEntity>> getOrders(String sid);
}
