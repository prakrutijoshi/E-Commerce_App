import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/user_model.dart';
import '../../../../utils/utils.dart';
import '../../../common_cubits/cubit/cubit/authentication_cubit.dart';
import '../../Support/supportscreen.dart';
import '../../myaccount/myaccount_screen.dart';
import '../../settings/settings_screen.dart';
import '../../shipping_address/shipping_address_screen.dart';
import '../cubit/profile_cubit.dart';
import 'profile_avatar.dart';
import 'profile_list.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileImageUploading) {
          UtilDialog.showWaiting(context);
        }
        if (state is ProfileImageUploaded) {
          UtilDialog.hideWaiting(context);
        }
        if (state is ProfileUpdating) {
          UtilDialog.showWaiting(context);
        }
        if (state is ProfileUpdated) {
          UtilDialog.hideWaiting(context);
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
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
            return Center(
              child: Text("Couldn't load data"),
            );
          }
        },
      ),
    );
  }
}

Widget _listView(UserModel user, BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Column(children: [
      ProfileAvatar(user: user),
      SizedBox(height: 20),
      ProfileList(
        text: "My Account",
        icon: "assets/icons/User Icon.svg",
        press: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyAccount(user: user))),
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
