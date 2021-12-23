import 'package:e_shop_seller/presentation/screens/login/components/login_form.dart';
import 'package:e_shop_seller/utils/size_config.dart';
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
            vertical: getProportionateScreenHeight(15),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "We Are Happy You Are Here!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: getProportionateScreenWidth(23),
                    ),
                  ),
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
