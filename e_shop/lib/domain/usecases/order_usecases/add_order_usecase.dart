import '../../entities/order_entity.dart';
import '../../repositories/firebase_order_repository.dart';

class AddOrderUseCase {
  final FirebaseOrderRepository repository;

  AddOrderUseCase({required this.repository});

  Future<void> call(OrderEntity newOrder) async {
    return await repository.addOrder(newOrder);
  }
}
