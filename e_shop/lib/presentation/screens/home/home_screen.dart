import 'package:e_shop/presentation/common_cubits/cubit/cubit/authentication_cubit.dart';
import 'package:e_shop/presentation/screens/home/components/body.dart';
import 'package:e_shop/presentation/screens/home/components/customnavbar.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/utils/enum.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  //final User currentUser;

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("e-Shop"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
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
      body: Body(),
      bottomNavigationBar: CustomNavBar(selected: Menu.home),
    );
  }
}
