import '../../entities/wishlist_item_entity.dart';
import '../../repositories/firebase_wishlist_repository.dart';

class RemoveWishListItemUseCase {
  final FirebaseWishListRepository repository;

  RemoveWishListItemUseCase({required this.repository});

  Future<void> call(String uid, WishListItemEntity deleteWishListItem) async {
    return await repository.rmeoveWishListItem(uid, deleteWishListItem);
  }
}
