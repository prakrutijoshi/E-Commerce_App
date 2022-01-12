import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/order_entity.dart';
import 'shipping_address_model.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required String oid,
    required String uid,
    required List<OrderModelItem> orderedItems,
    required String paymentMethod,
    required ShippingAddressModel shippingAddress,
    required String priceToBePaid,
    required String priceOfGoods,
    required String shippingCharges,
    required String discount,
    required Timestamp createdAt,
  }) : super(
          oid: oid,
          uid: uid,
          orderedItems: orderedItems,
          paymentMethod: paymentMethod,
          shippingAddress: shippingAddress,
          priceToBePaid: priceToBePaid,
          priceOfGoods: priceOfGoods,
          shippingCharges: shippingCharges,
          discount: discount,
          createdAt: createdAt,
        );

  Timestamp get receivedDate =>
      Timestamp.fromDate(this.createdAt.toDate().add(Duration(days: 5)));

  bool get isDelivering {
    var now = Timestamp.now();
    return now.compareTo(receivedDate) < 0;
  }

  factory OrderModel.fromMap(Map<String, dynamic> json) {
    List<OrderModelItem> orderedItems = [];
    if (json["orderedItems"] != null) {
      json["orderedItems"].forEach((orderedItem) {
        return orderedItems.add(OrderModelItem.fromMap(orderedItem));
      });
    }

    return OrderModel(
      oid: json["oid"],
      uid: json["uid"],
      orderedItems: orderedItems,
      paymentMethod: json["paymentMethod"],
      shippingAddress: ShippingAddressModel.fromMap(json["shippingAddress"]),
      priceToBePaid: json["priceToBePaid"],
      priceOfGoods: json["priceOfGoods"],
      shippingCharges: json["shippingCharges"],
      discount: json["discount"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toMap() {
    var orderedItems = this.orderedItems as List<OrderModelItem>;
    var shippingAddress = this.shippingAddress as ShippingAddressModel;

    return {
      "oid": this.oid,
      "uid": this.uid,
      "orderedItems": List<dynamic>.from(
          orderedItems.map((orderedItem) => orderedItem.toMap())),
      "paymentMethod": this.paymentMethod,
      "shippingAddress": shippingAddress.toMap(),
      "priceToBePaid": this.priceToBePaid,
      "priceOfGoods": this.priceOfGoods,
      "shippingCharges": this.shippingCharges,
      "discount": this.discount,
      "createdAt": this.createdAt,
    };
  }

  OrderModel cloneWith({
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
  }) {
    return OrderModel(
      oid: oid ?? this.oid,
      uid: uid ?? this.uid,
      orderedItems: orderedItems ?? this.orderedItems,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      priceToBePaid: priceToBePaid ?? priceToBePaid,
      priceOfGoods: priceOfGoods ?? this.priceOfGoods,
      shippingCharges: shippingCharges ?? this.shippingCharges,
      discount: discount ?? this.discount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OrderModelItem extends OrderEntityItem {
  OrderModelItem({
    required String productId,
    required String productName,
    required String productPrice,
    required String productImage,
    required String sellerId,
    required String orderedQuantity,
  }) : super(
          productId: productId,
          productName: productName,
          productPrice: productPrice,
          productImage: productImage,
          sellerId: sellerId,
          orderedQuantity: orderedQuantity,
        );

  factory OrderModelItem.fromMap(Map<String, dynamic> json) {
    return OrderModelItem(
      productId: json["productId"] ?? "",
      productName: json["productName"] ?? "",
      productImage: json["productImage"] ?? "",
      productPrice: json["productPrice"] ?? "",
      sellerId: json["sellerId"] ?? "",
      orderedQuantity: json["orderedQuantity"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "productId": this.productId,
      "productName": this.productName,
      "productImage": this.productImage,
      "productPrice": this.productPrice,
      "sellerId": this.sellerId,
      "orderedQuantity": this.orderedQuantity,
    };
  }
}
