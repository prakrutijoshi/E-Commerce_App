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
  Future<void> addTocart() async {
    // TODO: implement addTocart
  }

  @override
  Future<ProductEntity> findProduct() async {
    return await productDataSource.findProduct();
  }
}
