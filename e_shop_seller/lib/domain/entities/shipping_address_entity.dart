import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String aid;
  final String fullName;
  final String phoneNumber;
  final String detailedAddress;
  final String city;
  final String state;
  final String postal;
  final String country;
  final bool isDefault;

  ShippingAddressEntity({
    required this.aid,
    required this.fullName,
    required this.phoneNumber,
    required this.detailedAddress,
    required this.city,
    required this.state,
    required this.postal,
    required this.country,
    required this.isDefault,
  });

  @override
  List<Object> get props => [
        aid,
        fullName,
        phoneNumber,
        detailedAddress,
        city,
        state,
        postal,
        country,
        isDefault,
      ];
}
