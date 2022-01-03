import 'package:flutter/material.dart';

import '../../widgets/constants.dart';
import '../profile/components/profile_list.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
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
