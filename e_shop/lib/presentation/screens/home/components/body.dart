import 'package:e_shop/presentation/screens/home/components/categories.dart';
import 'package:e_shop/presentation/screens/home/components/discountbanner.dart';
import 'package:e_shop/presentation/screens/home/components/searchfield.dart';
import 'package:e_shop/presentation/screens/home/components/specialoffers.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
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
            SearchField(),
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
