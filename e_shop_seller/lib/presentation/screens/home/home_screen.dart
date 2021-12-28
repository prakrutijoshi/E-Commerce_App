import 'package:e_shop_seller/presentation/screens/product/add_product_screen.dart';
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
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationCubit>(context).loggedOut();
                Navigator.popUntil(context, ModalRoute.withName("/"));
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
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddProductScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  "Add New Product",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavBar(selected: Menu.home),
      ),
    );
  }
}
