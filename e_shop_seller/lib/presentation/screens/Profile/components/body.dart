import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_cubits/authentication/authentication_cubit.dart';
import 'profile_avatar.dart';
import 'profile_list.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
            text: "Orders",
            icon: "assets/icons/Parcel.svg",
            press: () {},
          ),
          ProfileList(
            text: "Logout",
            icon: "assets/icons/Log out.svg",
            press: () {
              BlocProvider.of<AuthenticationCubit>(context).loggedOut();
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
          ),
        ],
      ),
    );
  }
}
