import '../entities/product_entity.dart';

abstract class FirebaseProductRepository {
  Future<void> addProductData(ProductEntity newProduct);

  Future<void> updateProductData(ProductEntity updateProduct);

  Stream<List<ProductEntity>> getAvailableProductsBySellerId(
      int page, String sellerId);

  Stream<List<ProductEntity>> getUnAvailableProductsBySellerId(
      int page, String sellerId);

  Stream<ProductEntity> getProductById(String pid);

  Future<void> removeProduct(String pid);
}
