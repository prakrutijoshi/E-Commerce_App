import '../../entities/product_entity.dart';
import '../../repositories/firebase_product_repository.dart';

class GetProductBySellerIdUseCase {
  final FirebaseProductRepository repository;

  GetProductBySellerIdUseCase({required this.repository});

  Future<List<ProductEntity>> call(String sellerId) async {
    return await repository.getProductsBySellerId(sellerId);
  }
}
