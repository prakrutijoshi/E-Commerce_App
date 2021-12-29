import '../entities/product_entity.dart';

abstract class FirebaseProductRepository {
  Future<void> addProductData(ProductEntity newProduct);

  Future<void> updateProductData(ProductEntity updateProduct);

  Future<List<ProductEntity>> getAvailableProductsBySellerId(String sellerId);

  Future<List<ProductEntity>> getUnAvailableProductsBySellerId(String sellerId);

  Future<ProductEntity> getProductById(String pid);

  Future<void> removeProduct(String pid);
}
