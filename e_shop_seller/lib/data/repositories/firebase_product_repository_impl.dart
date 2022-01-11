import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/firebase_product_repository.dart';
import '../datasources/remote_datasource/firebase_product_remote_datasource.dart';
import '../models/product_model.dart';

class FirebaseProductRepositoryImpl implements FirebaseProductRepository {
  final FirebaseProductRemoteDatasource remoteDatasource;

  FirebaseProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> addProductData(ProductEntity newProduct) async {
    return await remoteDatasource.addProductData(newProduct as ProductModel);
  }

  @override
  Stream<ProductEntity> getProductById(String pid) {
    return remoteDatasource.getProductById(pid);
  }

  @override
  Stream<List<ProductEntity>> getAvailableProductsBySellerId(
      int page, String sellerId) {
    return remoteDatasource.getAvailableProductsBySellerId(page, sellerId);
  }

  @override
  Stream<List<ProductEntity>> getUnAvailableProductsBySellerId(
      int page, String sellerId) {
    return remoteDatasource.getUnAvailableProductsBySellerId(page, sellerId);
  }

  @override
  Future<void> removeProduct(String pid) async {
    return await remoteDatasource.removeProduct(pid);
  }

  @override
  Future<void> updateProductData(ProductEntity updateProduct) async {
    return await remoteDatasource
        .updateProductData(updateProduct as ProductModel);
  }
}
