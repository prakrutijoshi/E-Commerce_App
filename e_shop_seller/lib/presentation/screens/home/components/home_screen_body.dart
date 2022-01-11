import '../../product/add_product/add_product_screen.dart';
import '../../product/display_products/display_products_by_seller_screen.dart';
import '../../../../utils/default_button.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
