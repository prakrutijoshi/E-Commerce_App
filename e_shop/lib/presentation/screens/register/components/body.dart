import 'package:flutter/material.dart';

import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import 'register_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Register Account", style: headingStyle),
                Text(
                  "Complete your details to create \n your user account on eShop",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                RegisterForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
