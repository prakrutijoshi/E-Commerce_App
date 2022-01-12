import '../../domain/entities/shipping_address_entity.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  ShippingAddressModel({
    required String aid,
    required String fullName,
    required String phoneNumber,
    required String detailedAddress,
    required String city,
    required String state,
    required String postal,
    required String country,
    required bool isDefault,
  }) : super(
          aid: aid,
          fullName: fullName,
          phoneNumber: phoneNumber,
          detailedAddress: detailedAddress,
          city: city,
          state: state,
          postal: postal,
          country: country,
          isDefault: isDefault,
        );

  factory ShippingAddressModel.fromMap(Map<String, dynamic> json) {
    return ShippingAddressModel(
      aid: json["aid"] ?? "",
      fullName: json["fullName"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      detailedAddress: json["detailedAddress"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      postal: json["postal"] ?? "",
      country: json["country"] ?? "",
      isDefault: json["isDefault"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "aid": this.aid,
      "fullName": this.fullName,
      "phoneNumber": this.phoneNumber,
      "detailedAddress": this.detailedAddress,
      "city": this.city,
      "state": this.state,
      "postal": this.postal,
      "country": this.country,
      "isDefault": this.isDefault,
    };
  }

  ShippingAddressModel cloneWith({
    aid,
    fullName,
    phoneNumber,
    detailedAddress,
    city,
    state,
    postal,
    country,
    isDefault,
  }) {
    return ShippingAddressModel(
        aid: aid ?? this.aid,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        detailedAddress: detailedAddress ?? this.detailedAddress,
        city: city ?? this.city,
        state: state ?? this.state,
        postal: postal ?? this.postal,
        country: country ?? this.country,
        isDefault: isDefault ?? this.isDefault);
  }
}
