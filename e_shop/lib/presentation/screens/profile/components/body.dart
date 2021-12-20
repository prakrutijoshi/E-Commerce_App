import 'package:e_shop/presentation/common_blocs/cubit/cubit/authentication_cubit.dart';
import 'package:e_shop/presentation/screens/profile/components/profile_avatar.dart';
import 'package:e_shop/presentation/screens/profile/components/profile_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  var BlocProvider;

  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileAvatar(),
          SizedBox(height: 20),
          ProfileList(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {},
          ),
          ProfileList(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileList(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileList(
            text: "Support",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileList(
            text: "LogOut",
            icon: "assets/icons/Log out.svg",
            press: () =>
                BlocProvider.of<AuthenticationCubit>(context).loggedOut(),
          ),
        ],
      ),
    );
  }
}
