import '../entities/seller_entity.dart';

abstract class FirebaseUserRepository {
  Future<SellerEntity> getSellerById(String sid);

  Future<void> addSellerData(SellerEntity newSeller);

  Future<void> updateSellerData(SellerEntity updatedSeller);

  // Stream<SellerEntity> loggedSellerStream(User loggedFirebaseSeller);
}
