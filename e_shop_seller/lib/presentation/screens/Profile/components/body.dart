import 'package:e_shop_seller/data/models/seller_model.dart';
import 'package:e_shop_seller/presentation/screens/Profile/cubit/profile_cubit.dart';
import 'package:e_shop_seller/presentation/screens/myaccount/myaccount_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_cubits/authentication/authentication_cubit.dart';
import 'profile_avatar.dart';
import 'profile_list.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileInitial) {
        BlocProvider.of<ProfileCubit>(context).getSeller();
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ProfileLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ProfileLoaded) {
        var sellerList = state.seller;
        return _listView(sellerList, context);
      } else {
        print(state.toString());
        return Center(
          child: Text("Couldn't load data"),
        );
      }
    });
  }
}

Widget _listView(SellerModel seller, BuildContext context) {
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
                    builder: (context) => MyAccount(seller: seller)));
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
