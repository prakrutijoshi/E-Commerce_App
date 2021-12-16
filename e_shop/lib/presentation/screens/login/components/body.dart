import 'package:e_shop/presentation/screens/login/components/login_form.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(15)),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "We are Happy you are Here!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(23),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "One Step away from having the best online shopping experience!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(15)),
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
