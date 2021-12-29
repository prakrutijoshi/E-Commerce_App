import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(100)),
              Text(
                "e-Shop",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(46),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Enhance Your Business Online!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 15),
              ),
              Image.asset(
                "assets/images/splash_2.png",
                height: getProportionateScreenHeight(265),
                width: getProportionateScreenWidth(250),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
