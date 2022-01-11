import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../../data/model/wishlist_item_model.dart';
import '../../../../domain/entities/wishlist_item_entity.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import '../../../../domain/usecases/product_usecases/find_product_by_id_usecase.dart';
import '../../../../domain/usecases/wishlist_usecases/add_wishlist_item_usecase.dart';
import '../../../../domain/usecases/wishlist_usecases/clear_wishlist_usecase.dart';
import '../../../../domain/usecases/wishlist_usecases/fetch_wishlist_usecase.dart';
import '../../../../domain/usecases/wishlist_usecases/is_exists_in_wishlist_usecase.dart';
import '../../../../domain/usecases/wishlist_usecases/remove_wishlist_item_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final LoggedFirebaseUserUseCase loggedFirebaseUserUseCase;
  final FetchWishListUseCase fetchWishListUseCase;
  final AddWishListItemUseCase addWishListItemUseCase;
  final RemoveWishListItemUseCase removeWishListItemUseCase;
  final ClearWishListUseCase clearWishListUseCase;
  final FindProductByIdUsecase findProductByIdUsecase;
  final IsExistsInWishListUseCase isExistsInWishListUseCase;

  late StreamSubscription<List<WishListItemEntity>> fetchWishListItemsSub;

  WishlistCubit({
    required this.loggedFirebaseUserUseCase,
    required this.fetchWishListUseCase,
    required this.addWishListItemUseCase,
    required this.removeWishListItemUseCase,
    required this.clearWishListUseCase,
    required this.findProductByIdUsecase,
    required this.isExistsInWishListUseCase,
  }) : super(WishlistInitial());

  Future<void> fetchWishList() async {
    emit(WishListLoading());

    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      var streamWishListItems = fetchWishListUseCase.call(uid);

      fetchWishListItemsSub = streamWishListItems.listen((wishListItems) async {
        num priceOfGoods = 0;

        for (var i = 0; i < wishListItems.length; i++) {
          wishListItems = wishListItems as List<WishListItemModel>;
          priceOfGoods += num.parse(wishListItems[i].price);

          try {
            var productInfo =
                await findProductByIdUsecase.call(wishListItems[i].productId);

            wishListItems[i] =
                wishListItems[i].cloneWith(productInfo: productInfo);
          } catch (e) {
            emit(WishListFailure(message: "Failed to load WishList items"));
          }
        }

        emit(WishListLoaded(
          wishlistList: wishListItems as List<WishListItemModel>,
          priceOfGoods: priceOfGoods,
        ));
      });
    } catch (e) {
      emit(WishListFailure(message: "Failed to load wishlist items"));
    }
  }

  Future<void> addWishListItem(WishListItemModel newWishListItem) async {
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      await addWishListItemUseCase.call(uid, newWishListItem);
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeWishListItem(WishListItemModel deleteWishListItem) async {
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      await removeWishListItemUseCase.call(uid, deleteWishListItem);
    } catch (e) {
      print(e);
    }
  }

  Future<void> clearWishList() async {
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      await clearWishListUseCase.call(uid);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isExistsInWishList(String productId) async {
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;

      var isExists = await isExistsInWishListUseCase.call(uid, productId);
      print(isExists);
      return isExists;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<void> close() async {
    await fetchWishListItemsSub.cancel();
    return super.close();
  }
}
