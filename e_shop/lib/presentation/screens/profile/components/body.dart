import 'package:e_shop/data/model/user_model.dart';
import 'package:e_shop/presentation/screens/profile/cubit/profile_cubit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common_cubits/cubit/cubit/authentication_cubit.dart';
import '../../myaccount/myaccount_screen.dart';
import 'profile_avatar.dart';
import 'profile_list.dart';
import '../../shipping_address/shipping_address_screen.dart';
import 'package:flutter/material.dart';
import '../../Support/supportscreen.dart';
import '../../settings/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          BlocProvider.of<ProfileCubit>(context).getUser();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          var userList = state.users;
          return _listView(userList, context);
        } else {
          print(state.toString());
          return Center(
            child: Text("Couldn't load data"),
          );
        }
      },
    );
  }
}

Widget _listView(UserModel users, BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Column(children: [
      ProfileAvatar(
        user: users,
      ),
      SizedBox(height: 20),
      ProfileList(
        text: "My Account",
        icon: "assets/icons/User Icon.svg",
        press: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyAccount(user: users))),
      ),
      ProfileList(
        text: "Notifications",
        icon: "assets/icons/Bell.svg",
        press: () {},
      ),
      ProfileList(
        text: "Settings",
        icon: "assets/icons/Settings.svg",
        press: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingsScreen()));
        },
      ),
      ProfileList(
        text: "Support",
        icon: "assets/icons/Question mark.svg",
        press: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SupportScreen()));
        },
      ),
      ProfileList(
        text: "Addresses",
        icon: "assets/icons/Location point.svg",
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
    ]),
  );
}
