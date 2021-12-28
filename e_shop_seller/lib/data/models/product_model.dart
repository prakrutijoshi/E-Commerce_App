import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required String pid,
    required String name,
    required String description,
    required String category,
    required List<String> images,
    required String rating,
    required String quantity,
    required String price,
    required bool isAvailable,
    required String sellerId,
  }) : super(
          pid: pid,
          name: name,
          description: description,
          category: category,
          images: images,
          rating: rating,
          quantity: quantity,
          price: price,
          isAvailable: isAvailable,
          sellerId: sellerId,
        );

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      pid: data["pid"] ?? "",
      name: data["name"] ?? "",
      description: data["description"] ?? "",
      category: data["category"] ?? "",
      images: List.castFrom<dynamic, String>(data["images"]),
      rating: data["rating"],
      quantity: data["quantity"],
      price: data["price"],
      isAvailable: data["isAvailable"],
      sellerId: data["sellerId"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "pid": this.pid,
      "name": this.name,
      "description": this.description,
      "category": this.category,
      "images": this.images,
      "rating": this.rating,
      "quantity": this.quantity,
      "price": this.price,
      "isAvailable": this.isAvailable,
      "sellerId": this.sellerId
    };
  }

  ProductModel cloneWith({
    pid,
    name,
    description,
    category,
    images,
    rating,
    quantity,
    price,
    isAvailable,
    sellerId,
  }) {
    return ProductModel(
      pid: pid ?? this.pid,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      isAvailable: isAvailable ?? this.isAvailable,
      sellerId: sellerId ?? this.sellerId,
    );
  }
}
