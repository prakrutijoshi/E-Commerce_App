import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String pid;
  final String name;
  final String price;
  final String category;
  final String description;
  final List<String> images;
  final bool isAvailable;
  final String quantity;
  final String rating;
  final String sellerId;

  ProductEntity(
      {required this.pid,
      required this.name,
      required this.price,
      required this.category,
      required this.description,
      required this.images,
      required this.isAvailable,
      required this.quantity,
      required this.rating,
      required this.sellerId});

  @override
  List<Object?> get props => [
        pid,
        name,
        price,
        category,
        description,
        images,
        isAvailable,
        quantity,
        rating,
        sellerId,
      ];
}
