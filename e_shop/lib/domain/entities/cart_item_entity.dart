import 'package:equatable/equatable.dart';

import 'product_entity.dart';

class CartItemEntity extends Equatable {
  final String cid;
  final String productId;
  final String quantity;
  final String price;
  final ProductEntity? productInfo;
  CartItemEntity({
    required this.cid,
    required this.productId,
    required this.quantity,
    required this.price,
    this.productInfo,
  });

  @override
  List<Object?> get props => [
        cid,
        productId,
        quantity,
        price,
        productInfo,
      ];
}
