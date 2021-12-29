import '../../entities/product_entity.dart';
import '../../repositories/firebase_product_repository.dart';

class GetUnAvailableProductBySellerIdUseCase {
  final FirebaseProductRepository repository;

  GetUnAvailableProductBySellerIdUseCase({required this.repository});

  Future<List<ProductEntity>> call({required String sellerId}) async {
    return await repository.getUnAvailableProductsBySellerId(sellerId);
  }
}
