part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrdersLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<OrderModel> deliveringOrders;
  final List<OrderModel> deliveredOrders;

  OrdersLoaded({
    required this.deliveringOrders,
    required this.deliveredOrders,
  });

  @override
  List<Object> get props => [deliveringOrders, deliveredOrders];
}

class OrdersFailure extends OrderState {
  final String error;

  OrdersFailure(this.error);

  @override
  List<Object> get props => [error];
}
