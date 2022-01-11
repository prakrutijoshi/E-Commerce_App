import '../../entities/product_entity.dart';
import '../../repositories/firebase_product_repository.dart';

class GetUnAvailableProductBySellerIdUseCase {
  final FirebaseProductRepository repository;

  GetUnAvailableProductBySellerIdUseCase({required this.repository});

  Stream<List<ProductEntity>> call(int page, {required String sellerId}) {
    return repository.getUnAvailableProductsBySellerId(page, sellerId);
  }
}
