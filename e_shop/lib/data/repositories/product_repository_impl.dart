import 'package:e_shop/data/datasource/remote_datasource/productdatasource.dart';
import 'package:e_shop/domain/entities/product_entity.dart';
import 'package:e_shop/domain/repositories/product_repository.dart';

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
