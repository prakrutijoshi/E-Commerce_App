import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/cart_item_model.dart';
import '../../../widgets/size_config.dart';
import '../cubit/cart_cubit.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartInitial) {
          BlocProvider.of<CartCubit>(context).fetchCart();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartLoaded) {
          var cartList = state.cartList;
          var totalCartAmount = state.priceOfGoods;

          return _buildCartView(context, cartList, totalCartAmount);
        } else if (state is CartLoadFailure) {
          return Center(
            child: Text("Failed to load"),
          );
        } else {
          return Center(
            child: Text("Somthing went wrong"),
          );
        }
      },
    );
  }

  _buildCartView(
      BuildContext context, List<CartItemModel> cartList, num totalCartAmount) {
    return cartList.length > 0
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
                        cartList.length.toString() +
                            (cartList.length == 1 ? " ITEM" : " ITEMS"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Cart Total: ₹" + totalCartAmount.toString(),
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
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    CartItemModel cartItem = cartList[index];
                    return CartCard(cartItem: cartItem);
                  },
                ),
              ],
            ),
          )
        : Center(
            child: Text("Your cart is empty"),
          );
  }
}
