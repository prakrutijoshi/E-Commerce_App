import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../data/models/order_model.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_seller_usecase.dart';
import '../../../../domain/usecases/order_usecases/get_orders_usecase.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final GetOrdersUseCase getOrdersUseCase;
  final LoggedFirebaseSellerUseCase loggedFirebaseSellerUseCase;

  OrderCubit({
    required this.getOrdersUseCase,
    required this.loggedFirebaseSellerUseCase,
  }) : super(OrderInitial());

  Future<void> getOrders() async {
    emit(OrdersLoading());
    try {
      User loggedSeller = await loggedFirebaseSellerUseCase.call();
      String sid = loggedSeller.uid;

      var ordersDetails = await getOrdersUseCase.call(sid);
      var orders = ordersDetails as List<OrderModel>;

      // Separate orders
      List<OrderModel> deliveringOrders = [];
      List<OrderModel> deliveredOrders = [];

      orders.forEach((order) {
        if (order.isDelivering) {
          deliveringOrders.add(order);
        } else {
          // order.isDelivering == false
          deliveredOrders.add(order);
        }
      });

      emit(OrdersLoaded(
        deliveringOrders: deliveringOrders,
        deliveredOrders: deliveredOrders,
      ));
    } catch (e) {
      emit(OrdersFailure("Failed to load orders"));
    }
  }
}
