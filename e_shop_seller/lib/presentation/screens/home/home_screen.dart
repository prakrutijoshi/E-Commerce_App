import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/customnavbar.dart';
import '../../../utils/enum.dart';
import '../product/add_product_screen.dart';
import '../product/display_products_by_seller_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddProductScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                    ),
                    child: Text(
                      "Add New Product",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DisplayProductsBySellerScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                    ),
                    child: Text(
                      "Watch you products",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavBar(selected: Menu.home),
      ),
    );
  }
}
