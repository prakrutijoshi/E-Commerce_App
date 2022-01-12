import '../../entities/wishlist_item_entity.dart';
import '../../repositories/firebase_wishlist_repository.dart';

class AddWishListItemUseCase {
  final FirebaseWishListRepository repository;

  AddWishListItemUseCase({required this.repository});

  Future<void> call(String uid, WishListItemEntity newWishListItem) async {
    return await repository.addWishListItem(uid, newWishListItem);
  }
}
