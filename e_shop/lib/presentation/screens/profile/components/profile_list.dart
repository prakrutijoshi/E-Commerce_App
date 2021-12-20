import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileList extends StatelessWidget {
  ProfileList(
      {Key? key, required this.text, required this.icon, required this.press})
      : super(key: key);

  final String text, icon;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            //Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
