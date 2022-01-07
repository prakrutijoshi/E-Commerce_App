import 'package:e_shop/domain/entities/wishlist_item_entity.dart';
import 'package:e_shop/domain/repositories/firebase_wishlist_repository.dart';

class RemoveWishListItemUseCase {
  final FirebaseWishListRepository repository;

  RemoveWishListItemUseCase({required this.repository});

  Future<void> call(String uid, WishListItemEntity deleteWishListItem) async {
    return await repository.rmeoveWishListItem(uid, deleteWishListItem);
  }
}
