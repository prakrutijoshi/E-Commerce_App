import 'categories.dart';
import 'discountbanner.dart';
import 'products.dart';
import 'searchfield.dart';
import 'specialoffers.dart';
import '../../../widgets/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().initState(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            SearchField(),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            Products(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
