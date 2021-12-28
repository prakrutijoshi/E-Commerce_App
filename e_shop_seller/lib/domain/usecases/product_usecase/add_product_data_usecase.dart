import '../../entities/product_entity.dart';
import '../../repositories/firebase_product_repository.dart';

class AddProductDataUseCase {
  final FirebaseProductRepository repository;
  AddProductDataUseCase({required this.repository});

  Future<void> call(ProductEntity newProduct) async {
    return await repository.addProductData(newProduct);
  }
}
