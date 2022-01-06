import '../../entities/cart_item_entity.dart';
import '../../repositories/firebase_cart_repository.dart';

class UpdateCartItemUseCase {
  final FirebaseCartRepository repository;

  UpdateCartItemUseCase({required this.repository});

  Future<void> call(String uid, CartItemEntity updateCartItem) async {
    return await repository.updateCartItem(uid, updateCartItem);
  }
}
