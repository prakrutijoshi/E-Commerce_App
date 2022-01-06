import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilToast {
  static void showMessageForUser(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.black,
      // fontSize: SizeConfig.defaultSize * 1.6,
    );
  }
}
