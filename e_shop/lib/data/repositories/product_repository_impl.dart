import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/remote_datasource/productdatasource.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl(this.productDataSource);
  @override
  Future<List<ProductEntity>> fetchProducts() async {
    return await productDataSource.fetchProducts();
  }

  @override
  Future<ProductEntity> findProductById(String pid) async {
    return await productDataSource.findProductById(pid);
  }

  @override
  Future<List<ProductEntity>> findProductByCategory(String category) async {
    return await productDataSource.findProductByCategory(category);
  }

  @override
  Future<List<ProductEntity>> findProductByName(String name) async {
    return await productDataSource.findProductByName(name);
  }
}
