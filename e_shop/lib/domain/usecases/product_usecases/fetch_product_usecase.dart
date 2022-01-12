import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

class FetchProductUsecase {
  final ProductRepository repository;

  FetchProductUsecase(this.repository);

  Future<List<ProductEntity>> call(int page) async {
    return await repository.fetchProducts(page);
  }
}
