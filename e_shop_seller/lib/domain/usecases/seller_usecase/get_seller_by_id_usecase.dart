import '../../entities/seller_entity.dart';
import '../../repositories/firebase_seller_repository.dart';

class GetSellerByIdUseCase {
  FirebaseSellerRepository repository;

  GetSellerByIdUseCase({required this.repository});

  Future<SellerEntity> call(String sid) async {
    return await repository.getSellerById(sid);
  }
}
