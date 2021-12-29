import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchProducts();
  Future<void> addTocart();
  Future<ProductEntity> findProduct();
}
