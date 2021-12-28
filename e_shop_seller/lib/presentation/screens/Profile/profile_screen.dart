import 'package:e_shop_seller/presentation/screens/Profile/components/body.dart';
import 'package:e_shop_seller/utils/constants.dart';
import 'package:e_shop_seller/utils/customnavbar.dart';
import 'package:e_shop_seller/utils/enum.dart';
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
      ),
      body: Body(),
      bottomNavigationBar: CustomNavBar(selected: Menu.profile),
    );
  }
}
