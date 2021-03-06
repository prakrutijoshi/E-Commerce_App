import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts(int page);
  Future<ProductModel> findProductById(String pid);
  Future<List<ProductModel>> findProductByCategory(String category, int page);
  Future<List<ProductModel>> getAllProducts();
}

class ProductDataSourceImpl extends ProductDataSource {
  var _productcollaction = FirebaseFirestore.instance.collection('products');

  @override
  Future<List<ProductModel>> fetchProducts(int page) async {
    print(page);
    return await _productcollaction
        .limit(6 * page)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList())
        .catchError((error) {
      print(error);
    });
  }

  @override
  Future<ProductModel> findProductById(String pid) async {
    return await _productcollaction
        .doc(pid)
        .get()
        .then((doc) => ProductModel.fromMap(doc.data()!))
        .catchError((error) {
      print(error);
    });
  }

  @override
  Future<List<ProductModel>> findProductByCategory(
      String category, int page) async {
    print(page);
    return await _productcollaction
        .where("category", isEqualTo: category)
        .limit(6 * page)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList())
        .catchError((error) {
      print(error);
    });
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    return await _productcollaction
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList())
        .catchError((error) {
      print(error);
    });
  }
}
