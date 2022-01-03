import '../../../../data/model/product_model.dart';
import 'product_description.dart';
import 'product_images.dart';
import 'rounded_container.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../../../utils/default_button.dart';
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
