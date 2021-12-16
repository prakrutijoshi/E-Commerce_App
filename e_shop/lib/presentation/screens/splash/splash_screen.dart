import 'package:e_shop/presentation/screens/splash/components/body.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
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
