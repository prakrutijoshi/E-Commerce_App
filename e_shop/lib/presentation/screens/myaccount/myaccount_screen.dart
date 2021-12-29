import '../Cart/cart_screen.dart';

import '../../widgets/constants.dart';
import '../profile/components/profile_list.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

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
              text: "Prakruti Joshi",
              icon: "assets/icons/User.svg",
              press: () {},
            ),
            ProfileList(
              text: "joshiprakruti7@gmail.com",
              icon: "assets/icons/Mail.svg",
              press: () {},
            ),
            ProfileList(
                text: "Wishlist",
                icon: "assets/icons/Heart Icon.svg",
                press: () {}),
            ProfileList(
                text: "Cart",
                icon: "assets/icons/Cart Icon.svg",
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
