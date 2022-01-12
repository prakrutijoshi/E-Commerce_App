import '../../entities/wishlist_item_entity.dart';
import '../../repositories/firebase_wishlist_repository.dart';

class FetchWishListUseCase {
  final FirebaseWishListRepository repository;

  FetchWishListUseCase({required this.repository});

  Stream<List<WishListItemEntity>> call(String uid) {
    return repository.fetchWishList(uid);
  }
}
