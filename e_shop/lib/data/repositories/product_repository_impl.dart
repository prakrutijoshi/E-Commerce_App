import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/remote_datasource/productdatasource.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl(this.productDataSource);
  @override
  Future<List<ProductEntity>> fetchProducts(int page) async {
    return await productDataSource.fetchProducts(page);
  }

  @override
  Future<ProductEntity> findProductById(String pid) async {
    return await productDataSource.findProductById(pid);
  }

  @override
  Future<List<ProductEntity>> findProductByCategory(
      String category, int page) async {
    return await productDataSource.findProductByCategory(category, page);
  }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    return await productDataSource.getAllProducts();
  }
}
