import 'package:e_shop/presentation/screens/Checkout/checkout_screen.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
import 'package:e_shop/utils/default_button.dart';

import 'components/body.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: _buildOrderNowButton(context),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Column(
      children: [
        Text(
          "Your Cart",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "2 items",
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    ),
  );
}

_buildOrderNowButton(context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
    child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: DefaultButton(
        text: "Order Now",
        press: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => checkoutScreen()));
        },
      ),
    ),
  );
}
