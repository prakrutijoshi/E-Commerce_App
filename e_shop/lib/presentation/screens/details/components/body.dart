import 'package:e_shop/data/model/product_model.dart';
import 'package:e_shop/presentation/screens/details/components/product_description.dart';
import 'package:e_shop/presentation/screens/details/components/product_images.dart';
import 'package:e_shop/presentation/screens/details/components/rounded_container.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
import 'package:e_shop/utils/default_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final ProductModel product;
  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        RoundedContainer(
          color: kSecondaryColor,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                SeeMore: () {},
              ),
              RoundedContainer(
                color: kSecondaryColor,
                child: Column(
                  children: [
                    RoundedContainer(
                      color: kSecondaryColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add to Cart",
                          press: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
