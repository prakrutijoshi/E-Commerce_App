import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/product_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required String cid,
    required String productId,
    required String quantity,
    required String price,
    ProductEntity? productInfo,
  }) : super(
          cid: cid,
          productId: productId,
          quantity: quantity,
          price: price,
          productInfo: productInfo,
        );

  factory CartItemModel.fromMap(Map<String, dynamic> json) {
    return CartItemModel(
      cid: json["cid"] ?? "",
      productId: json["productId"],
      price: json["price"],
      quantity: json["quantity"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "cid": this.cid,
      "productId": this.productId,
      "price": this.price,
      "quantity": this.quantity,
    };
  }

  CartItemModel cloneWith({
    cid,
    productId,
    productInfo,
    price,
    quantity,
  }) {
    return CartItemModel(
      cid: cid ?? this.cid,
      productId: productId ?? this.productId,
      productInfo: productInfo ?? this.productInfo,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
