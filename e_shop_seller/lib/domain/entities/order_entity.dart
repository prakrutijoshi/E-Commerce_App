import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'shipping_address_entity.dart';

class OrderEntity extends Equatable {
  final String oid;
  final String uid;
  final List<OrderEntityItem> orderedItems;
  final String paymentMethod;
  final ShippingAddressEntity shippingAddress;
  final String priceToBePaid;
  final String priceOfGoods;
  final String shippingCharges;
  final String discount;
  final Timestamp createdAt;
  OrderEntity({
    required this.oid,
    required this.uid,
    required this.orderedItems,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.priceToBePaid,
    required this.priceOfGoods,
    required this.shippingCharges,
    required this.discount,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        oid,
        uid,
        orderedItems,
        paymentMethod,
        shippingAddress,
        priceToBePaid,
        priceOfGoods,
        shippingCharges,
        discount,
        createdAt,
      ];
}

class OrderEntityItem extends Equatable {
  final String productId;
  final String productName;
  final String productPrice;
  final String productImage;
  final String sellerId;
  final String orderedQuantity;
  OrderEntityItem({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.sellerId,
    required this.orderedQuantity,
  });

  @override
  List<Object?> get props => [
        productId,
        productName,
        productPrice,
        productImage,
        sellerId,
        orderedQuantity,
      ];
}
