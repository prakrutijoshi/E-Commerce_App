part of 'outofstockproducts_cubit.dart';

abstract class OutofstockproductsState extends Equatable {
  const OutofstockproductsState();

  @override
  List<Object> get props => [];
}

class OutofstockproductsInitial extends OutofstockproductsState {}

class OutofstockproductsLoading extends OutofstockproductsState {}

class OutofstockproductsLoaded extends OutofstockproductsState {
  final List<ProductModel> products;

  OutofstockproductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class OutofstockproductsError extends OutofstockproductsState {
  final String message;

  OutofstockproductsError({required this.message});

  @override
  List<Object> get props => [message];
}
