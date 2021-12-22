import 'package:equatable/equatable.dart';

class SellerEntity extends Equatable {
  final String sid;
  final String email;
  final String name;
  final String avatar;
  final String phoneNumber;

  SellerEntity({
    required this.sid,
    required this.email,
    required this.name,
    required this.avatar,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        sid,
        email,
        name,
        avatar,
        phoneNumber,
      ];
}
