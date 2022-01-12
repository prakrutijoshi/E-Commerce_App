import 'package:e_shop/presentation/screens/my_orders/cubit/my_order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../WishList/wishlist_screen.dart';
import '../my_orders/my_order_screen.dart';
import 'package:flutter/material.dart';

import '../../../data/model/user_model.dart';
import '../../widgets/constants.dart';
import '../Cart/cart_screen.dart';
import '../profile/components/profile_list.dart';

class MyAccount extends StatelessWidget {
  final UserModel user;
  MyAccount({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("User"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            ProfileList(
              text: user.name,
              icon: "assets/icons/User.svg",
              press: () {},
            ),
            ProfileList(
              text: user.email,
              icon: "assets/icons/Mail.svg",
              press: () {},
            ),
            ProfileList(
                text: "Wishlist",
                icon: "assets/icons/Heart Icon.svg",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WishListScreen()),
                  );
                }),
            ProfileList(
                text: "Cart",
                icon: "assets/icons/Cart Icon.svg",
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                }),
            ProfileList(
              text: "Orders",
              icon: "assets/icons/Parcel.svg",
              press: () {
                BlocProvider.of<MyOrderCubit>(context).getOrders();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOrderScreen(showAppBar: true),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
