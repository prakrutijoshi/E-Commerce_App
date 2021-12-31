import 'constants.dart';
import 'package:flutter/material.dart';

class UtilDialog {
  static showInformation(
    BuildContext context, {
    String? title,
    String? content,
    Function()? onClose,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? "message for you",
          ),
          content: Text(content!),
          actions: <Widget>[
            TextButton(
              child: Text(
                "close",
              ),
              onPressed: onClose ?? () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  static showWaiting(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 150,
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  static hideWaiting(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String title,
    required void Function() onYesPressed,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "No",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 5,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton(
              child: Text(
                "Yes",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 5,
              ),
              onPressed: onYesPressed,
            ),
          ],
        );
      },
    );
  }
}
