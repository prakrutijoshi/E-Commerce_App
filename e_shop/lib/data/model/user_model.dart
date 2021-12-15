import '../../domain/entities/user_entity.dart';
import 'shipping_address_model.dart';

class UserModel extends UserEntity {
  UserModel({
    required String uid,
    required String email,
    required String name,
    required String avatar,
    required String phoneNumber,
    required List<ShippingAddressModel> addresses,
  }) : super(
          uid: uid,
          email: email,
          name: name,
          avatar: avatar,
          phoneNumber: phoneNumber,
          addresses: addresses,
        );

  factory UserModel.fromMap(Map<String, dynamic> data) {
    List<ShippingAddressModel> addresses = [];
    if (data["addresses"] != null) {
      data["addresses"].forEach((item) {
        addresses.add(ShippingAddressModel.fromMap(item));
      });
    }
    return UserModel(
      uid: data["uid"] ?? "",
      email: data["email"] ?? "",
      name: data["name"] ?? "",
      avatar: data["avatar"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      addresses: addresses,
    );
  }

  Map<String, dynamic> toMap() {
    var addresses = this.addresses as List<ShippingAddressModel>;
    return {
      "uid": this.uid,
      "email": this.email,
      "name": this.name,
      "avatar": this.avatar,
      "phoneNumber": this.phoneNumber,
      "addresses": List<dynamic>.from(addresses.map((item) => item.toMap()))
    };
  }

  UserModel cloneWith({
    uid,
    email,
    name,
    avatar,
    phoneNumber,
    addresses,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addresses: addresses ?? this.addresses,
    );
  }
}
