import 'components/body.dart';
import '../home/components/customnavbar.dart';
import '../../widgets/constants.dart';
import '../../../utils/enum.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("Your Profile"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
      bottomNavigationBar: CustomNavBar(selected: Menu.profile),
    );
  }
}
