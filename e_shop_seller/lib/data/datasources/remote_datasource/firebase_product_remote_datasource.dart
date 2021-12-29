import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/product_model.dart';

abstract class FirebaseProductRemoteDatasource {
  Future<void> addProductData(ProductModel newProduct);

  Future<void> updateProductData(ProductModel updateProduct);

  Future<List<ProductModel>> getAvailableProductsBySellerId(String sellerId);

  Future<List<ProductModel>> getUnAvailableProductsBySellerId(String sellerId);

  Future<ProductModel> getProductById(String pid);

  Future<void> removeProduct(String pid);
}

class FirebaseProductRemoteDatasourceImpl
    implements FirebaseProductRemoteDatasource {
  var _productCollection = FirebaseFirestore.instance.collection("products");

  @override
  Future<void> addProductData(ProductModel newProduct) async {
    return await _productCollection
        .doc(newProduct.pid)
        .set(newProduct.toMap())
        .catchError((error) => print(error));
  }

  @override
  Future<List<ProductModel>> getAvailableProductsBySellerId(
      String sellerId) async {
    return await _productCollection
        .where("sellerId", isEqualTo: sellerId)
        .where("isAvailable", isEqualTo: true)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList())
        .catchError((error) {
      print(error);
    });
  }

  @override
  Future<List<ProductModel>> getUnAvailableProductsBySellerId(
      String sellerId) async {
    return await _productCollection
        .where("sellerId", isEqualTo: sellerId)
        .where("isAvailable", isEqualTo: false)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList())
        .catchError((error) {
      print(error);
    });
  }

  @override
  Future<ProductModel> getProductById(String pid) async {
    return await _productCollection
        .doc(pid)
        .get()
        .then((doc) => ProductModel.fromMap(doc.data()!))
        .catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> removeProduct(String pid) async {
    return await _productCollection
        .doc(pid)
        .delete()
        .catchError((error) => print(error));
  }

  @override
  Future<void> updateProductData(ProductModel updateProduct) async {
    return await _productCollection
        .doc(updateProduct.pid)
        .get()
        .then((doc) async {
      if (doc.exists) {
        await doc.reference.update(updateProduct.toMap());
      }
    }).catchError((error) {
      print(error);
    });
  }
}
