import '../../common_cubits/cubit/cubit/authentication_cubit.dart';
import 'components/body.dart';
import 'components/customnavbar.dart';
import '../../widgets/constants.dart';
import '../../../utils/enum.dart';

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
