import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/seller_model.dart';
import '../../../../utils/dialog.dart';
import '../../../common_cubits/authentication/authentication_cubit.dart';
import '../../myaccount/myaccount_screen.dart';
import '../cubit/profile_cubit.dart';
import 'profile_avatar.dart';
import 'profile_list.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
      child: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        if (state is ProfileInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          var seller = state.seller;
          return _listView(context, seller: seller);
        } else {
          return Center(
            child: Text("Couldn't load data"),
          );
        }
      }),
    );
  }
}

Widget _listView(BuildContext context, {required SellerModel seller}) {
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        ProfileAvatar(seller: seller),
        SizedBox(height: 20),
        ProfileList(
          text: "My Account",
          icon: "assets/icons/User Icon.svg",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyAccount(seller: seller),
              ),
            );
          },
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
