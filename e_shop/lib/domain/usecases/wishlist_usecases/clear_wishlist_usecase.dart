import '../../repositories/firebase_wishlist_repository.dart';

class ClearWishListUseCase {
  final FirebaseWishListRepository repository;

  ClearWishListUseCase({required this.repository});

  Future<void> call(String uid) async {
    return await repository.clearWishList(uid);
  }
}
