import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/constants.dart';
import '../../widgets/size_config.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().initState(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kPrimaryColor, kSecondaryColor],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 300.0, left: 110, right: 150),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/icons/Cart Icon.svg",
                  height: 180,
                  width: 180,
                  color: kPrimaryColor,
                ),
                SizedBox(height: 10),
                Text(
                  "<--eShop-->",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 22,
                      color: kPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
