import '../../entities/seller_entity.dart';
import '../../repositories/firebase_seller_repository.dart';

class AddSellerDataUseCase {
  FirebaseSellerRepository repository;

  AddSellerDataUseCase({required this.repository});

  Future<void> call(SellerEntity newSeller) async {
    return await repository.addSellerData(newSeller);
  }
}
