import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../data/model/order_model.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import '../../../../domain/usecases/order_usecases/add_order_usecase.dart';
import '../../../../domain/usecases/order_usecases/get_orders_usecase.dart';
import '../../../../domain/usecases/order_usecases/remove_order_usecase.dart';

part 'my_order_state.dart';

class MyOrderCubit extends Cubit<MyOrderState> {
  final GetOrdersUseCase getOrdersUseCase;
  final AddOrderUseCase addOrderUseCase;
  final RemoveOrderUseCase removeOrderUseCase;
  final LoggedFirebaseUserUseCase loggedFirebaseUserUseCase;

  MyOrderCubit({
    required this.getOrdersUseCase,
    required this.addOrderUseCase,
    required this.removeOrderUseCase,
    required this.loggedFirebaseUserUseCase,
  }) : super(MyOrderInitial());

  Future<void> getOrders() async {
    emit(MyOrdersLoading());
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      var ordersDetails = await getOrdersUseCase.call(uid);
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

      emit(MyOrdersLoaded(
        deliveringOrders: deliveringOrders,
        deliveredOrders: deliveredOrders,
      ));
    } catch (e) {
      emit(MyOrdersFailure("Failed to load orders"));
    }
  }

  Future<void> addOrderItem({required OrderModel newOrder}) async {
    try {
      await addOrderUseCase.call(newOrder);
    } catch (e) {
      emit(MyOrdersFailure(e.toString()));
    }
  }

  Future<void> removeOrderItem({required OrderModel deleteOrder}) async {
    try {
      await removeOrderUseCase.call(deleteOrder);
      getOrders();
    } catch (e) {
      emit(MyOrdersFailure(e.toString()));
    }
  }
}
