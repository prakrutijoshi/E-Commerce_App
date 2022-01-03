import '../../entities/product_entity.dart';
import '../../repositories/firebase_product_repository.dart';

class GetAvailableProductBySellerIdUseCase {
  final FirebaseProductRepository repository;

  GetAvailableProductBySellerIdUseCase({required this.repository});

  Stream<List<ProductEntity>> call({required String sellerId}) {
    return repository.getAvailableProductsBySellerId(sellerId);
  }
}
