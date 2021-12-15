import 'package:equatable/equatable.dart';

import 'shipping_address_entity.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String avatar;
  final String phoneNumber;
  final List<ShippingAddressEntity> addresses;

  UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.avatar,
    required this.phoneNumber,
    required this.addresses,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        name,
        avatar,
        phoneNumber,
        addresses,
      ];
}
