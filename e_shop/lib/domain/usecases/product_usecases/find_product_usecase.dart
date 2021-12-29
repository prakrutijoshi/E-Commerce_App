import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

class FindProductUsecase {
  final ProductRepository repository;

  FindProductUsecase(this.repository);

  Future<ProductEntity> call() async {
    return await repository.findProduct();
  }
}
