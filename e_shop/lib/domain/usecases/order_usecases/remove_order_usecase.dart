import '../../entities/order_entity.dart';
import '../../repositories/firebase_order_repository.dart';

class RemoveOrderUseCase {
  final FirebaseOrderRepository repository;

  RemoveOrderUseCase({required this.repository});

  Future<void> call(OrderEntity deleteOrder) async {
    return await repository.removeOrder(deleteOrder);
  }
}
