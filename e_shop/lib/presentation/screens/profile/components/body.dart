import '../../../common_cubits/cubit/cubit/authentication_cubit.dart';
import '../../myaccount/myaccount_screen.dart';
import 'profile_avatar.dart';
import 'profile_list.dart';
import '../../shipping_address/shipping_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
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
            press: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyAccount())),
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
            text: "Addresses",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShippingAddressScreen(),
                ),
              );
            },
          ),
          ProfileList(
            text: "LogOut",
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
