import 'package:flutter/material.dart';

import 'size_config.dart';

const kPrimaryColor = Color(0xFF512DA8);
const kPrimaryLightColor = Color(0xFF9575CD);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Colors.deepPurpleAccent, Color(0xFF80CBC4)],
);
const kSecondaryColor = Color(0xFFE3F2FD);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
