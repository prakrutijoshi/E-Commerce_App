import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/data/model/product_model.dart';

abstract class ProductDataSource {
  Future<void> fetchProducts();
  Future<void> addTocart();
  Future<ProductModel> findProduct();
}

class ProductDataSourceImpl extends ProductDataSource {
  var _productcollaction = FirebaseFirestore.instance;

  @override
  Future<void> fetchProducts() async {
    return await _productcollaction
        .collection('products')
        .get()
        .then((value) => value.docs.forEach((result) {
              print(result);
            }));
  }

  @override
  Future<void> addTocart() async {
    // TODO: implement addTocart
  }

  @override
  Future<ProductModel> findProduct() {
    // TODO: implement findProduct
    throw UnimplementedError();
  }
}
