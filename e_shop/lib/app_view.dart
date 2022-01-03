import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/common_cubits/cubit/cubit/authentication_cubit.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/splash/splash_screen1.dart';
import 'presentation/screens/splash/splash_screen2.dart';
import 'utils/theme.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eShop',
      theme: theme(),
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, authState) {
          BlocProvider.of<AuthenticationCubit>(context).appStarted();
          if (authState is AuthInitial) {
            return SplashScreen1();
          } else if (authState is Unauthenticated) {
            return SplashScreen2();
          } else if (authState is Authenticated) {
            return HomeScreen();
          } else {
            return SplashScreen1();
          }
        },
      ),
    );
  }
}
