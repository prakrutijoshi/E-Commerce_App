import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../presentation/screens/Profile/profile_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import 'constants.dart';
import 'enum.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key, required this.selected}) : super(key: key);
  final Menu selected;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: kPrimaryColor,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                color:
                    Menu.home == selected ? kPrimaryColor : inActiveIconColor,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
              onPressed: () {},
            ),
            IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: Menu.profile == selected
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()))),
          ],
        ),
      ),
    );
  }
}
