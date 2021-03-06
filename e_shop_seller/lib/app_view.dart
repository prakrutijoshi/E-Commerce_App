import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/common_cubits/authentication/authentication_cubit.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/login/login_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'utils/theme.dart';

class AppView extends StatefulWidget {
  //final SellerModel user;
  AppView({
    Key? key,
    //required this.user
  }) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState(
      //user: user
      );
}

class _AppViewState extends State<AppView> {
  //final SellerModel user;

  _AppViewState(
      //required this.user
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eShop Seller',
      theme: theme(),
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, authState) {
          if (authState is AuthenticationInitial) {
            BlocProvider.of<AuthenticationCubit>(context).appStarted();
            return SplashScreen();
          } else if (authState is Unauthenticated) {
            return LoginScreen();
          } else if (authState is Authenticated) {
            return HomeScreen(
                //user: user
                );
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}
