import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchProducts(int page);
  Future<ProductEntity> findProductById(String pid);
  Future<List<ProductEntity>> findProductByCategory(String category, int page);
  Future<List<ProductEntity>> getAllProducts();
}
