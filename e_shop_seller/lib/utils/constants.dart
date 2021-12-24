import 'package:e_shop_seller/utils/size_config.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFFB74D);
const kPrimaryLightColor = Color(0xFFFFECB3);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Colors.deepOrangeAccent, Color(0xFF80CBC4)],
);
const kSecondaryColor = Color(0xFFFFE0B2);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
