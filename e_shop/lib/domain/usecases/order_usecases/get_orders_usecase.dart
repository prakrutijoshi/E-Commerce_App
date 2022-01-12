import '../../entities/order_entity.dart';
import '../../repositories/firebase_order_repository.dart';

class GetOrdersUseCase {
  final FirebaseOrderRepository repository;

  GetOrdersUseCase({required this.repository});

  Future<List<OrderEntity>> call(String uid) async {
    return await repository.getOrders(uid);
  }
}
