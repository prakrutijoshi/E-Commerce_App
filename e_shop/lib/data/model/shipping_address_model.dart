import '../../domain/entities/shipping_address_entity.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  ShippingAddressModel({
    required String fullName,
    required String phoneNumber,
    required String deatiledAddress,
    required String city,
    required String state,
    required String postal,
    required String country,
    required bool isDefault,
  }) : super(
          fullName: fullName,
          phoneNumber: phoneNumber,
          deatiledAddress: deatiledAddress,
          city: city,
          state: state,
          postal: postal,
          country: country,
          isDefault: isDefault,
        );

  factory ShippingAddressModel.fromMap(Map<String, dynamic> json) {
    return ShippingAddressModel(
      fullName: json["fullName"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      deatiledAddress: json["address"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      postal: json["postal"] ?? "",
      country: json["country"] ?? "",
      isDefault: json["isDefault"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "fullName": this.fullName,
      "phoneNumber": this.phoneNumber,
      "deatiledAddress": this.deatiledAddress,
      "city": this.city,
      "state": this.state,
      "postal": this.postal,
      "country": this.country,
      "isDefault": this.isDefault,
    };
  }

  ShippingAddressModel cloneWith({
    fullName,
    phoneNumber,
    deatiledAddress,
    city,
    state,
    postal,
    country,
    isDefault,
  }) {
    return ShippingAddressModel(
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        deatiledAddress: deatiledAddress ?? this.deatiledAddress,
        city: city ?? this.city,
        state: state ?? this.state,
        postal: postal ?? this.postal,
        country: country ?? this.country,
        isDefault: isDefault ?? this.isDefault);
  }
}
