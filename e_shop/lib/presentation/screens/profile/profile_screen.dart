import 'package:flutter/material.dart';

import '../../../utils/customnavbar.dart';
import '../../../utils/enum.dart';
import '../../widgets/constants.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("Your Profile"),
        centerTitle: true,
      ),
      body: Body(),
      bottomNavigationBar: CustomNavBar(selected: Menu.profile),
    );
  }
}
