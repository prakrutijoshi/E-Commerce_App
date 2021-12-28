import '../../repositories/firebase_seller_repository.dart';

class IsExistInCollectionUseCase {
  FirebaseSellerRepository repository;

  IsExistInCollectionUseCase({required this.repository});

  Future<bool> call(String sid) async {
    return await repository.isExistInCollection(sid);
  }
}
