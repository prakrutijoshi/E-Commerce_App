import 'package:e_shop/presentation/screens/Cart/components/body.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
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
