import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchProducts();
  Future<ProductEntity> findProductById(String pid);
  Future<List<ProductEntity>> findProductByCategory(String category);
  Future<List<ProductEntity>> findProductByName(String name);
}
