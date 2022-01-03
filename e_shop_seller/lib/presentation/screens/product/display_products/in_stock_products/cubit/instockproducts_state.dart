part of 'instockproducts_cubit.dart';

abstract class InstockproductsState extends Equatable {
  const InstockproductsState();

  @override
  List<Object> get props => [];
}

class InstockproductsInitial extends InstockproductsState {}

class InstockproductsLoading extends InstockproductsState {}

class InstockproductsLoaded extends InstockproductsState {
  final List<ProductModel> products;

  InstockproductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class InstockproductsError extends InstockproductsState {
  final String message;

  InstockproductsError({required this.message});

  @override
  List<Object> get props => [message];
}
