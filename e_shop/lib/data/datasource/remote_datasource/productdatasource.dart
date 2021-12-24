import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/data/model/product_model.dart';
import 'package:flutter/widgets.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<void> addTocart();
  Future<ProductModel> findProduct();
}

class ProductDataSourceImpl extends ProductDataSource {
  var _productcollaction = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<ProductModel>> fetchProducts() async {
    return await _productcollaction
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList())
        .catchError((error) {
      print(error);
    });
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
