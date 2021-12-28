import '../../entities/product_entity.dart';
import '../../repositories/firebase_product_repository.dart';

class UpdateProductDataUseCase {
  final FirebaseProductRepository repository;

  UpdateProductDataUseCase({required this.repository});

  Future<void> call(ProductEntity updateProduct) async {
    return await repository.updateProductData(updateProduct);
  }
}
