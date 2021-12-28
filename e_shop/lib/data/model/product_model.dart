import 'package:e_shop/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required String pid,
      required String name,
      required String price,
      required String category,
      required String description,
      required List<String> images,
      required bool isAvailable,
      required String quantity,
      required String rating,
      required String sellerId})
      : super(
            pid: pid,
            name: name,
            price: price,
            category: category,
            description: description,
            images: images,
            isAvailable: isAvailable,
            quantity: quantity,
            rating: rating,
            sellerId: sellerId);

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      pid: json["pid"] ?? "",
      name: json["name"] ?? "",
      price: json["price"] ?? "",
      category: json["category"] ?? "",
      description: json["description"] ?? "",
      images: List.castFrom<dynamic, String>(json["images"]),
      isAvailable: json["isAvailable"] ?? "",
      quantity: json["quantity"] ?? "",
      rating: json["rating"] ?? "",
      sellerId: json["sellerId"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "pid": this.pid,
      "name": this.name,
      "price": this.price,
      "category": this.category,
      "description": this.description,
      "images": this.images,
      "isAvailable": this.isAvailable,
      "quantity": this.quantity,
      "rating": this.rating,
      "sellerId": this.sellerId,
    };
  }

  ProductModel cloneWith(
      {pid,
      name,
      price,
      category,
      description,
      images,
      isAvailable,
      quantity,
      rating,
      sellerId}) {
    return ProductModel(
        pid: pid ?? this.pid,
        name: name ?? this.name,
        price: price ?? this.price,
        category: category ?? this.category,
        description: description,
        images: images ?? this.images,
        isAvailable: isAvailable ?? this.isAvailable,
        quantity: quantity ?? this.quantity,
        rating: rating ?? this.rating,
        sellerId: sellerId ?? this.sellerId);
  }
}
