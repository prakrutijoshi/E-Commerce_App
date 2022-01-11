import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

class FindProductByCategoryUsecase {
  final ProductRepository repository;

  FindProductByCategoryUsecase(this.repository);

  Future<List<ProductEntity>> call(String category, int page) async {
    return await repository.findProductByCategory(category, page);
  }
}
