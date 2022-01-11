import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/default_button.dart';
import 'in_stock_products/InStockProducts.dart';
import 'out_of_stock_products/outOfStockProducts.dart';

class DisplayProductsBySellerScreen extends StatefulWidget {
  const DisplayProductsBySellerScreen({Key? key}) : super(key: key);

  @override
  _DisplayProductsBySellerScreenState createState() =>
      _DisplayProductsBySellerScreenState();
}

class _DisplayProductsBySellerScreenState
    extends State<DisplayProductsBySellerScreen> {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OutOfStockProducts(),
                      ),
                    );
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
