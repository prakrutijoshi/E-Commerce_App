import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

class FindProductByIdUsecase {
  final ProductRepository repository;

  FindProductByIdUsecase(this.repository);

  Future<ProductEntity> call(String pid) async {
    return await repository.findProductById(pid);
  }
}
