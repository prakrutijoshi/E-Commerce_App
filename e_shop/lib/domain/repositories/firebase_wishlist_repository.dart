import '../entities/wishlist_item_entity.dart';

abstract class FirebaseWishListRepository {
  Stream<List<WishListItemEntity>> fetchWishList(String uid);

  Future<void> addWishListItem(String uid, WishListItemEntity newWishListItem);

  Future<void> rmeoveWishListItem(
      String uid, WishListItemEntity deleteWishListItem);

  Future<void> clearWishList(String uid);

  Future<bool> isExistsInWishList(String uid, String productId);
}
