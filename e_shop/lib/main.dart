import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;
import 'presentation/common_blocs/cubit/cubit/authentication_cubit.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/login/login_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthenticationCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
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
      ),
    );
  }
}
