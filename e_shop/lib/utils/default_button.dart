import 'package:flutter/material.dart';

import '../presentation/widgets/constants.dart';
import '../presentation/widgets/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(45),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: getProportionateScreenWidth(18)),
        ),
      ),
    );
  }
}
