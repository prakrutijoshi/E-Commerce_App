import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String deatiledAddress;
  final String city;
  final String state;
  final String postal;
  final String country;
  final bool isDefault;

  ShippingAddressEntity({
    required this.fullName,
    required this.phoneNumber,
    required this.deatiledAddress,
    required this.city,
    required this.state,
    required this.postal,
    required this.country,
    required this.isDefault,
  });

  @override
  List<Object> get props => [
        fullName,
        phoneNumber,
        deatiledAddress,
        city,
        state,
        postal,
        country,
        isDefault,
      ];
}
