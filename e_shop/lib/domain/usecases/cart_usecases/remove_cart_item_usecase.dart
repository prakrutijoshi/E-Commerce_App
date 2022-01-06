import '../../entities/cart_item_entity.dart';
import '../../repositories/firebase_cart_repository.dart';

class RemoveCartItemUseCase {
  final FirebaseCartRepository repository;

  RemoveCartItemUseCase({required this.repository});

  Future<void> call(String uid, CartItemEntity deleteCartItem) async {
    return await repository.removeCartItem(uid, deleteCartItem);
  }
}
