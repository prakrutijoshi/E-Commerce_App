import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/firebase_cart_repository.dart';
import '../datasource/remote_datasource/firebase_cart_remote_datasource.dart';
import '../model/cart_item_model.dart';

class FirebaseCartRepositoryImpl implements FirebaseCartRepository {
  final FirebaseCartRemoteDatasource remoteDatasource;

  FirebaseCartRepositoryImpl({required this.remoteDatasource});

  @override
  Stream<List<CartItemEntity>> fetchCart(String uid) {
    return remoteDatasource.fetchCart(uid);
  }

  @override
  Future<void> addCartItem(String uid, CartItemEntity newCartItem) async {
    return await remoteDatasource.addCartItem(
      uid,
      newCartItem as CartItemModel,
    );
  }

  @override
  Future<void> removeCartItem(String uid, CartItemEntity deleteCartItem) async {
    return await remoteDatasource.removeCartItem(
      uid,
      deleteCartItem as CartItemModel,
    );
  }

  @override
  Future<void> updateCartItem(String uid, CartItemEntity updateCartItem) async {
    return await remoteDatasource.updateCartItem(
      uid,
      updateCartItem as CartItemModel,
    );
  }

  @override
  Future<void> clearCart(String uid) async {
    return await remoteDatasource.clearCart(uid);
  }
}
