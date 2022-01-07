import 'package:e_shop/data/model/wishlist_item_model.dart';
import 'package:e_shop/presentation/screens/WishList/components/wishlist_card.dart';
import 'package:e_shop/presentation/screens/WishList/cubit/wishlist_cubit.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(builder: (context, state) {
      if (state is WishlistInitial) {
        BlocProvider.of<WishlistCubit>(context).fetchWishList();
        return Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
            backgroundColor: kSecondaryColor,
          ),
        );
      } else if (state is WishListLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
            backgroundColor: kSecondaryColor,
          ),
        );
      } else if (state is WishListLoaded) {
        var wishlistList = state.wishlistList;
        var totalAmount = state.priceOfGoods;

        return _buildWishListView(context, wishlistList, totalAmount);
      } else if (state is WishListFailure) {
        return Center(
          child: Text("Failed to load"),
        );
      } else {
        return Center(
          child: Text("something went wrong"),
        );
      }
    });
  }

  _buildWishListView(BuildContext context, List<WishListItemModel> wishlistList,
      num totalAmount) {
    return wishlistList.length > 0
        ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        wishlistList.length.toString() +
                            (wishlistList.length == 1 ? "ITEM" : "ITEMS"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: kPrimaryColor),
                      ),
                      Text(
                        "Total: ₹" + totalAmount.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(16),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: wishlistList.length,
                  itemBuilder: (context, index) {
                    WishListItemModel wishlistItem = wishlistList[index];
                    return WishListCard(wishlistItem: wishlistItem);
                  },
                ),
              ],
            ),
          )
        : Center(
            child: Text("Your WishList is empty"),
          );
  }
}
