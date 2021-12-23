import 'package:e_shop/presentation/screens/profile/components/profile_list.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            ProfileList(
              text: "Country & Language",
              icon: '',
              press: () {},
            ),
            ProfileList(
              text: "Permissions",
              icon: '',
              press: () {},
            ),
            ProfileList(
              text: "Rate Our App",
              icon: '',
              press: () {},
            ),
            ProfileList(
              text: "Legal & About",
              icon: '',
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
