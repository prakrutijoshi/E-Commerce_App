import 'components/InStockProducts.dart';
import '../../../utils/constants.dart';
import 'package:flutter/material.dart';

class DisplayProductsBySellerScreen extends StatelessWidget {
  const DisplayProductsBySellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Products"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InStockProducts(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  "In Stock Products",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => AddProductScreen(),
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  "Out of Stock Products",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
