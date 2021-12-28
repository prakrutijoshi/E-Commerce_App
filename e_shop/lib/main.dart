import 'package:e_shop/presentation/screens/home/cubit/product_cubit.dart';

import 'presentation/common_cubits/cubit/cubit/authentication_cubit.dart';
import 'presentation/screens/shipping_address/cubit/address_cubit.dart';

import 'app_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

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
        BlocProvider(
          create: (_) => di.sl<AddressCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<ProductCubit>(),
        ),
      ],
      child: AppView(),
    );
  }
}
