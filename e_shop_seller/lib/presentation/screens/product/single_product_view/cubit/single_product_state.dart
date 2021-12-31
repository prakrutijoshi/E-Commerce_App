part of 'single_product_cubit.dart';

abstract class SingleProductState extends Equatable {
  const SingleProductState();

  @override
  List<Object> get props => [];
}

class SingleProductInitial extends SingleProductState {}

class SingleProductDeleting extends SingleProductState {}

class SingleProductDeleted extends SingleProductState {}

class SingleProductError extends SingleProductState {
  final String message;

  SingleProductError({required this.message});

  @override
  List<Object> get props => [message];
}
