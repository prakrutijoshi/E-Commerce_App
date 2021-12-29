import 'components/body.dart';
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
