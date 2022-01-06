import '../../entities/cart_item_entity.dart';
import '../../repositories/firebase_cart_repository.dart';

class AddCartItemUseCase {
  final FirebaseCartRepository repository;

  AddCartItemUseCase({required this.repository});

  Future<void> call(String uid, CartItemEntity newCartItem) async {
    return await repository.addCartItem(uid, newCartItem);
  }
}
