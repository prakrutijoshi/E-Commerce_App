import 'package:e_shop/presentation/screens/profile/components/body.dart';
import 'package:e_shop/presentation/screens/home/components/customnavbar.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/utils/enum.dart';
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
