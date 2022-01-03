import '../../repositories/product_repository.dart';

import '../../entities/product_entity.dart';

class FindProductByNameUsecase {
  final ProductRepository repository;

  FindProductByNameUsecase(this.repository);

  Future<List<ProductEntity>> call(String name) async {
    return await repository.findProductByName(name);
  }
}
