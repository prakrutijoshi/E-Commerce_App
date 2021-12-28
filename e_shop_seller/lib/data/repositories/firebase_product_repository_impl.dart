import '../datasources/remote_datasource/firebase_product_remote_datasource.dart';
import '../models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/firebase_product_repository.dart';

class FirebaseProductRepositoryImpl implements FirebaseProductRepository {
  final FirebaseProductRemoteDatasource remoteDatasource;

  FirebaseProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> addProductData(ProductEntity newProduct) async {
    return await remoteDatasource.addProductData(newProduct as ProductModel);
  }

  @override
  Future<ProductEntity> getProductById(String pid) async {
    return await remoteDatasource.getProductById(pid);
  }

  @override
  Future<List<ProductEntity>> getProductsBySellerId(String sellerId) async {
    return await remoteDatasource.getProductsBySellerId(sellerId);
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
