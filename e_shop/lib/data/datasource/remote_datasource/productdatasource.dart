import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> findProductById(String pid);
  Future<List<ProductModel>> findProductByCategory(String category);
  Future<List<ProductModel>> findProductByName(String name);
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
  Future<List<ProductModel>> findProductByCategory(String category) async {
    return await _productcollaction
        .where("category", isEqualTo: category)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList())
        .catchError((error) {
      print(error);
    });
  }

  @override
  Future<List<ProductModel>> findProductByName(String name) async {
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
