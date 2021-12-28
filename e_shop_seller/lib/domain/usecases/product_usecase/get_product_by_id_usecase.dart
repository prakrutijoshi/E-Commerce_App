import '../../entities/product_entity.dart';
import '../../repositories/firebase_product_repository.dart';

class GetProductByIdUseCase {
  final FirebaseProductRepository repository;

  GetProductByIdUseCase({required this.repository});

  Future<ProductEntity> call(String pid) async {
    return await repository.getProductById(pid);
  }
}
