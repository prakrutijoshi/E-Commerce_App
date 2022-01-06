import '../entities/cart_item_entity.dart';

abstract class FirebaseCartRepository {
  Stream<List<CartItemEntity>> fetchCart(String uid);

  Future<void> addCartItem(String uid, CartItemEntity newCartItem);

  Future<void> removeCartItem(String uid, CartItemEntity deleteCartItem);

  Future<void> clearCart(String uid);

  Future<void> updateCartItem(String uid, CartItemEntity updateCartItem);
}
