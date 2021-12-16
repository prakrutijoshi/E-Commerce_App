import 'presentation/common_blocs/cubit/cubit/authentication_cubit.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/login/login_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, authState) {
          if (authState is AuthInitial) {
            BlocProvider.of<AuthenticationCubit>(context).appStarted();
            return SplashScreen();
          } else if (authState is Unauthenticated) {
            return LoginScreen();
          } else if (authState is Authenticated) {
            return HomeScreen(currentUser: authState.loggedFirebaseUser);
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}
