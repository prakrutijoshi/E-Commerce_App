import 'package:e_shop/presentation/screens/searchedscreen/cubit/search_cubit.dart';
import 'package:e_shop/presentation/screens/profile/cubit/profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_view.dart';
import 'injection_container.dart' as di;
import 'presentation/common_cubits/cubit/cubit/authentication_cubit.dart';
import 'presentation/screens/home/cubit/product_cubit.dart';
import 'presentation/screens/shipping_address/cubit/address_cubit.dart';

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
        BlocProvider(
          create: (_) => di.sl<SearchCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<ProfileCubit>(),
        ),
      ],
      child: AppView(),
    );
  }
}
