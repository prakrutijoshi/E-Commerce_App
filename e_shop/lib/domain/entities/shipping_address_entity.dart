import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String fullName;
  final String address;
  final String city;
  final String state;
  final String postal;
  final String country;
  final bool isDefault;

  ShippingAddressEntity({
    required this.fullName,
    required this.address,
    required this.city,
    required this.state,
    required this.postal,
    required this.country,
    required this.isDefault,
  });

  @override
  List<Object> get props => [
        fullName,
        address,
        city,
        state,
        postal,
        country,
        isDefault,
      ];
}
