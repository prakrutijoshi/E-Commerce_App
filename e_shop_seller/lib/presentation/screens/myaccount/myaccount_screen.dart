import 'package:e_shop_seller/data/models/seller_model.dart';
import 'package:e_shop_seller/presentation/screens/Profile/components/profile_list.dart';
import 'package:e_shop_seller/utils/constants.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  final SellerModel seller;
  const MyAccount({Key? key, required this.seller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text('Seller'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            ProfileList(
              text: seller.name,
              icon: "assets/icons/User.svg",
              press: () {},
            ),
            ProfileList(
              text: seller.email,
              icon: "assets/icons/Mail.svg",
              press: () {},
            ),
            // ProfileList(
            //   text: ,
            //   icon: icon,
            //   press: press,
            // ),
          ],
        ),
      ),
    );
  }
}
