import '../entities/seller_entity.dart';

abstract class FirebaseSellerRepository {
  Future<SellerEntity> getSellerById(String sid);

  Future<void> addSellerData(SellerEntity newSeller);

  Future<void> updateSellerData(SellerEntity updatedSeller);

  Future<bool> isExistInCollection(String sid);

  // Stream<SellerEntity> loggedSellerStream(User loggedFirebaseSeller);
}
