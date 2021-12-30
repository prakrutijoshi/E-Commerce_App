import 'package:e_shop_seller/utils/default_button.dart';

import 'components/InStockProducts.dart';
import '../../../utils/constants.dart';
import 'package:flutter/material.dart';

class DisplayProductsBySellerScreen extends StatelessWidget {
  const DisplayProductsBySellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          title: Text("Your Products"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 35.0, left: 35.0),
                child: DefaultButton(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InStockProducts(),
                      ),
                    );
                  },
                  text: "In Stock Products",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: DefaultButton(
                  press: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => AddProductScreen(),
                    //   ),
                    // );
                  },
                  text: "Out of Stock Products",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
