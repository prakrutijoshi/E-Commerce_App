import '../../entities/seller_entity.dart';
import '../../repositories/firebase_seller_repository.dart';

class UpdateSellerDataUseCase {
  FirebaseSellerRepository repository;

  UpdateSellerDataUseCase({required this.repository});

  Future<void> call(SellerEntity updatedSeller) async {
    return await repository.updateSellerData(updatedSeller);
  }
}
