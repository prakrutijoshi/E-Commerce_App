part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> cartList;
  final num priceOfGoods;

  CartLoaded({
    required this.cartList,
    required this.priceOfGoods,
  });

  @override
  List<Object> get props => [cartList, priceOfGoods];
}

class CartLoadFailure extends CartState {
  final String message;

  CartLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
