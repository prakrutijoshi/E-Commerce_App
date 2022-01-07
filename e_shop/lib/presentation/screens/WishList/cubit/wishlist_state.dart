part of 'wishlist_cubit.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishListLoading extends WishlistState {}

class WishListLoaded extends WishlistState {
  final List<WishListItemModel> wishlistList;
  final num priceOfGoods;

  WishListLoaded({
    required this.wishlistList,
    required this.priceOfGoods,
  });

  @override
  List<Object> get props => [wishlistList, priceOfGoods];
}

class WishListFailure extends WishlistState {
  final String message;

  WishListFailure({required this.message});

  @override
  List<Object> get props => [message];
}
