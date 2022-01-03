part of 'update_product_cubit.dart';

abstract class UpdateProductState extends Equatable {
  const UpdateProductState();

  @override
  List<Object> get props => [];
}

class UpdateProductInitial extends UpdateProductState {}

class ProductUpdating extends UpdateProductState {}

class UpdateProductDone extends UpdateProductState {}

class UpdateProductError extends UpdateProductState {
  final String message;

  UpdateProductError({required this.message});

  @override
  List<Object> get props => [message];
}
