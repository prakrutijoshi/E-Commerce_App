import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String pid;
  final String name;
  final String description;
  final String category;
  final List<String> images;
  final String rating;
  final String quantity;
  final String price;
  final bool isAvailable;
  final String sellerId;

  ProductEntity({
    required this.pid,
    required this.name,
    required this.description,
    required this.category,
    required this.images,
    required this.rating,
    required this.quantity,
    required this.price,
    required this.isAvailable,
    required this.sellerId,
  });

  @override
  List<Object?> get props => [
        pid,
        name,
        description,
        category,
        images,
        rating,
        quantity,
        price,
        isAvailable,
        sellerId,
      ];
}
