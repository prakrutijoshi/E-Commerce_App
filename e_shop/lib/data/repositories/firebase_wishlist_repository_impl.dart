import '../../domain/entities/wishlist_item_entity.dart';
import '../../domain/repositories/firebase_wishlist_repository.dart';
import '../datasource/remote_datasource/firebase_wishlist_remote%20datasource.dart';
import '../model/wishlist_item_model.dart';

class FirebaseWishListRepositoryImpl implements FirebaseWishListRepository {
  final FirebaseWishlistRemoteDatasource remoteDatasource;

  FirebaseWishListRepositoryImpl({required this.remoteDatasource});

  @override
  Stream<List<WishListItemEntity>> fetchWishList(String uid) {
    return remoteDatasource.fetchWishList(uid);
  }

  @override
  Future<void> addWishListItem(
      String uid, WishListItemEntity newWishListItem) async {
    return await remoteDatasource.addWishListItem(
      uid,
      newWishListItem as WishListItemModel,
    );
  }

  @override
  Future<void> rmeoveWishListItem(
      String uid, WishListItemEntity deleteWishListItem) async {
    return await remoteDatasource.removeWishListItem(
      uid,
      deleteWishListItem as WishListItemModel,
    );
  }

  @override
  Future<bool> isExistsInWishList(String uid, String productId) async {
    return await remoteDatasource.isExistsInWishList(uid, productId);
  }

  @override
  Future<void> clearWishList(String uid) async {
    return await remoteDatasource.clearWishList(uid);
  }
}
