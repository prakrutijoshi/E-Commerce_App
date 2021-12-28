import 'package:e_shop/domain/entities/product_entity.dart';
import 'package:e_shop/domain/repositories/product_repository.dart';

class FindProductUsecase {
  final ProductRepository repository;

  FindProductUsecase(this.repository);

  Future<ProductEntity> call() async {
    return await repository.findProduct();
  }
}
