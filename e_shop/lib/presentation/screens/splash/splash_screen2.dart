import 'components/body.dart';
import '../../widgets/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().initState(context);
    return Scaffold(
      body: Body(),
    );
  }
}
