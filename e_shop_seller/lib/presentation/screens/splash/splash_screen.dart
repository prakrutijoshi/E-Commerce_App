import 'package:e_shop_seller/presentation/screens/splash/components/body.dart';
import 'package:e_shop_seller/utils/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
