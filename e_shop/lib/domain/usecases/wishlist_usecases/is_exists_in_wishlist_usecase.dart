import 'package:e_shop/domain/repositories/firebase_wishlist_repository.dart';

class IsExistsInWishListUseCase {
  final FirebaseWishListRepository repository;

  IsExistsInWishListUseCase({required this.repository});

  Future<bool> call(String uid, String productId) {
    return repository.isExistsInWishList(uid, productId);
  }
}
