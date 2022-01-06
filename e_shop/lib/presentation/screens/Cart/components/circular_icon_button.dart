import '../../../widgets/constants.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final Function? onPressed;
  final IconData icon;
  final Color buttonColor;
  final Color iconColor;

  const CircleIconButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.buttonColor = kSecondaryColor,
    this.iconColor = kPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: CircleBorder(),
      ),
      child: Icon(
        icon,
        size: 17,
        color: iconColor,
      ),
    );
  }
}
