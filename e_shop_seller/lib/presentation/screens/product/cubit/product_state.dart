part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ImagesUploading extends ProductState {}

class ImagesUploaded extends ProductState {}

class ProductUploading extends ProductState {}

class ProductUploaded extends ProductState {}

class ImagesUploadError extends ProductState {
  final String message;

  ImagesUploadError({required this.message});

  List<Object> get props => [message];
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});

  List<Object> get props => [message];
}
