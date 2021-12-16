import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          "e-Shop",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(46),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(text),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(250),
        ),
      ],
    );
  }
}
