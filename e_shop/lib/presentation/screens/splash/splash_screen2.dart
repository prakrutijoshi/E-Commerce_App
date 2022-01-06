import 'package:flutter/material.dart';

import '../../widgets/size_config.dart';
import 'components/body.dart';

class SplashScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().initState(context);
    return Scaffold(
      body: Body(),
    );
  }
}
