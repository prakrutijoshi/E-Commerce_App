import 'categories.dart';
import 'discountbanner.dart';
import 'header.dart';
import 'specialoffers.dart';
import '../../../widgets/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Header(),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            // Products(),
            // SizedBox(height: getProportionateScreenWidth(30),),
          ],
        ),
      ),
    );
  }
}
