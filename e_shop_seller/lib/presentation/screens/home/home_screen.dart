import 'package:e_shop_seller/utils/constants.dart';
import 'package:e_shop_seller/utils/customnavbar.dart';
import 'package:e_shop_seller/utils/enum.dart';

import '../../common_cubits/authentication/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          title: Text("e-Shop Seller"),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationCubit>(context).loggedOut();
              },
              child: Text("Logout"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("home screen"),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavBar(selected: Menu.home),
      ),
    );
  }
}
