import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Body(),
    );
  }
}
