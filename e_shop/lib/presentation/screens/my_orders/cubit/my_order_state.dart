part of 'my_order_cubit.dart';

abstract class MyOrderState extends Equatable {
  const MyOrderState();

  @override
  List<Object> get props => [];
}

class MyOrderInitial extends MyOrderState {}

class MyOrdersLoading extends MyOrderState {}

class MyOrdersLoaded extends MyOrderState {
  final List<OrderModel> deliveringOrders;
  final List<OrderModel> deliveredOrders;

  MyOrdersLoaded({
    required this.deliveringOrders,
    required this.deliveredOrders,
  });

  @override
  List<Object> get props => [deliveringOrders, deliveredOrders];
}

class MyOrdersFailure extends MyOrderState {
  final String error;

  MyOrdersFailure(this.error);

  @override
  List<Object> get props => [error];
}
