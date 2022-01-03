import '../entities/product_entity.dart';

abstract class FirebaseProductRepository {
  Future<void> addProductData(ProductEntity newProduct);

  Future<void> updateProductData(ProductEntity updateProduct);

  Stream<List<ProductEntity>> getAvailableProductsBySellerId(String sellerId);

  Stream<List<ProductEntity>> getUnAvailableProductsBySellerId(String sellerId);

  Stream<ProductEntity> getProductById(String pid);

  Future<void> removeProduct(String pid);
}
