import 'package:equatable/equatable.dart';

import 'product_entity.dart';

class WishListItemEntity extends Equatable {
  final String wid;
  final String productId;
  final String price;
  final ProductEntity? productInfo;
  WishListItemEntity({
    required this.wid,
    required this.productId,
    required this.price,
    this.productInfo,
  });

  @override
  List<Object?> get props => [
        wid,
        productId,
        price,
        productInfo,
      ];
}
