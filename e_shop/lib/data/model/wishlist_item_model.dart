import 'package:e_shop/domain/entities/product_entity.dart';
import 'package:e_shop/domain/entities/wishlist_item_entity.dart';

class WishListItemModel extends WishListItemEntity {
  WishListItemModel({
    required String wid,
    required String productId,
    required String price,
    ProductEntity? productInfo,
  }) : super(
          wid: wid,
          productId: productId,
          price: price,
          productInfo: productInfo,
        );

  factory WishListItemModel.fromMap(Map<String, dynamic> json) {
    return WishListItemModel(
      wid: json["wid"] ?? "",
      productId: json["productId"],
      price: json["price"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "wid": this.wid,
      "productId": this.productId,
      "price": this.price,
    };
  }

  WishListItemModel cloneWith({
    wid,
    productId,
    productInfo,
    price,
  }) {
    return WishListItemModel(
      wid: wid ?? this.wid,
      productId: productId ?? this.productId,
      price: price ?? this.price,
      productInfo: productInfo ?? this.productInfo,
    );
  }
}
