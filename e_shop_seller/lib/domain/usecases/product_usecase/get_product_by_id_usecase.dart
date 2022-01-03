import '../../entities/product_entity.dart';
import '../../repositories/firebase_product_repository.dart';

class GetProductByIdUseCase {
  final FirebaseProductRepository repository;

  GetProductByIdUseCase({required this.repository});

  Stream<ProductEntity> call(String pid) {
    return repository.getProductById(pid);
  }
}
