import '../../domain/entities/seller_entity.dart';

class SellerModel extends SellerEntity {
  SellerModel({
    required String sid,
    required String email,
    required String name,
    required String avatar,
    required String phoneNumber,
  }) : super(
          sid: sid,
          email: email,
          name: name,
          avatar: avatar,
          phoneNumber: phoneNumber,
        );

  factory SellerModel.fromMap(Map<String, dynamic> data) {
    return SellerModel(
      sid: data["sid"] ?? "",
      email: data["email"] ?? "",
      name: data["name"] ?? "",
      avatar: data["avatar"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "sid": this.sid,
      "email": this.email,
      "name": this.name,
      "avatar": this.avatar,
      "phoneNumber": this.phoneNumber,
    };
  }

  SellerModel cloneWith({
    sid,
    email,
    name,
    avatar,
    phoneNumber,
  }) {
    return SellerModel(
      sid: sid ?? this.sid,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
