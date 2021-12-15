import '../../common_blocs/cubit/cubit/authentication_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final User currentUser;

  const HomeScreen({Key? key, required this.currentUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("e-Shop"),
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
          Text(currentUser.uid),
        ],
      ),
    );
  }
}
