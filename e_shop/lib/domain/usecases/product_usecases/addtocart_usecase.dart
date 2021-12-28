import 'package:e_shop/domain/repositories/product_repository.dart';

class AddToCartUsecase {
  final ProductRepository repository;

  AddToCartUsecase(this.repository);

  Future<void> call() async {
    return await repository.addTocart();
  }
}
