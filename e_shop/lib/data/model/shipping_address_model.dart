import '../../domain/entities/shipping_address_entity.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  ShippingAddressModel({
    required String fullName,
    required String address,
    required String city,
    required String state,
    required String postal,
    required String country,
    required bool isDefault,
  }) : super(
          fullName: fullName,
          address: address,
          city: city,
          state: state,
          postal: postal,
          country: country,
          isDefault: isDefault,
        );

  factory ShippingAddressModel.fromMap(Map<String, dynamic> json) {
    return ShippingAddressModel(
      fullName: json["fullName"] ?? "",
      address: json["address"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      postal: json["postal"] ?? "",
      country: json["country"] ?? "",
      isDefault: json["isDefault"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "address": address,
      "city": city,
      "state": state,
      "postal": postal,
      "country": country,
      "isDefault": isDefault,
    };
  }
}
