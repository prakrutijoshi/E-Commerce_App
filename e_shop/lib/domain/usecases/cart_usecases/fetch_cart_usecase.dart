import '../../entities/cart_item_entity.dart';
import '../../repositories/firebase_cart_repository.dart';

class FetchCartUseCase {
  final FirebaseCartRepository repository;

  FetchCartUseCase({required this.repository});

  Stream<List<CartItemEntity>> call(String uid) {
    return repository.fetchCart(uid);
  }
}
