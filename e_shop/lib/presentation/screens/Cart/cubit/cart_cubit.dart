import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../data/model/cart_item_model.dart';
import '../../../../domain/entities/cart_item_entity.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import '../../../../domain/usecases/cart_usecases/add_cart_item_usecase.dart';
import '../../../../domain/usecases/cart_usecases/clear_cart_usecase.dart';
import '../../../../domain/usecases/cart_usecases/fetch_cart_usecase.dart';
import '../../../../domain/usecases/cart_usecases/remove_cart_item_usecase.dart';
import '../../../../domain/usecases/cart_usecases/update_cart_item_usecase.dart';
import '../../../../domain/usecases/product_usecases/find_product_by_id_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final LoggedFirebaseUserUseCase loggedFirebaseUserUseCase;
  final FetchCartUseCase fetchCartUseCase;
  final AddCartItemUseCase addCartItemUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;
  final UpdateCartItemUseCase updateCartItemUseCase;
  final ClearCartUseCase clearCartUseCase;
  final FindProductByIdUsecase findProductByIdUsecase;

  late StreamSubscription<List<CartItemEntity>> fetchCartItemsSub;

  CartCubit({
    required this.loggedFirebaseUserUseCase,
    required this.fetchCartUseCase,
    required this.addCartItemUseCase,
    required this.removeCartItemUseCase,
    required this.updateCartItemUseCase,
    required this.clearCartUseCase,
    required this.findProductByIdUsecase,
  }) : super(CartInitial());

  Future<void> fetchCart() async {
    emit(CartLoading());
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      var streamCartItems = fetchCartUseCase.call(uid);

      fetchCartItemsSub = streamCartItems.listen((cartItems) async {
        num priceOfGoods = 0;

        for (var i = 0; i < cartItems.length; i++) {
          cartItems = cartItems as List<CartItemModel>;
          priceOfGoods += num.parse(cartItems[i].price);

          try {
            var productInfo =
                await findProductByIdUsecase.call(cartItems[i].productId);

            cartItems[i] = cartItems[i].cloneWith(productInfo: productInfo);
          } catch (e) {
            emit(CartLoadFailure(message: "Failed to load cart items"));
          }
        }

        emit(CartLoaded(
          cartList: cartItems as List<CartItemModel>,
          priceOfGoods: priceOfGoods,
        ));
      });
    } catch (e) {
      emit(CartLoadFailure(message: "Failed to load cart items"));
    }
  }

  Future<void> addCartItem(CartItemModel newCartItem) async {
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      await addCartItemUseCase.call(uid, newCartItem);
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeCartItem(CartItemModel deleteCartItem) async {
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      await removeCartItemUseCase.call(uid, deleteCartItem);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCartItem(CartItemModel updateCartItem) async {
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      await updateCartItemUseCase.call(uid, updateCartItem);
    } catch (e) {
      print(e);
    }
  }

  Future<void> clearCart() async {
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      await clearCartUseCase.call(uid);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> close() async {
    await fetchCartItemsSub.cancel();
    return super.close();
  }
}
