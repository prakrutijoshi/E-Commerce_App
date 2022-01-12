import '../../entities/order_entity.dart';
import '../../repositories/firebase_order_repository.dart';

class GetOrdersUseCase {
  final FirebaseOrderRepository repository;

  GetOrdersUseCase({required this.repository});

  Future<List<OrderEntity>> call(String sid) async {
    return await repository.getOrders(sid);
  }
}
