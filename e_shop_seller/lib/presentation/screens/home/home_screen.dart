import '../../../utils/default_button.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/customnavbar.dart';
import '../../../utils/enum.dart';
import '../product/add_product/add_product_screen.dart';
import '../product/display_products/display_products_by_seller_screen.dart';

class HomeScreen extends StatelessWidget {
  //final User currentUser;
  //final SellerModel user;
  const HomeScreen({
    Key? key,
    //required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          title: Text("e-Shop Seller"),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: DefaultButton(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddProductScreen(),
                          ),
                        );
                      },
                      text: "Add New Product",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                    child: DefaultButton(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DisplayProductsBySellerScreen(),
                          ),
                        );
                      },
                      text: "Watch your products",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavBar(
          selected: Menu.home,
          //user: user
        ),
      ),
    );
  }
}
