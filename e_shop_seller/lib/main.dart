import 'presentation/screens/orders/cubit/order_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_view.dart';
import 'injection_container.dart' as di;
import 'presentation/common_cubits/authentication/authentication_cubit.dart';
import 'presentation/screens/Profile/cubit/profile_cubit.dart';
import 'presentation/screens/product/add_product/cubit/product_cubit.dart';
import 'presentation/screens/product/display_products/in_stock_products/cubit/instockproducts_cubit.dart';
import 'presentation/screens/product/display_products/out_of_stock_products/cubit/outofstockproducts_cubit.dart';
import 'presentation/screens/product/single_product_view/cubit/single_product_cubit.dart';
import 'presentation/screens/product/update_product/cubit/update_product_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<ProductCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<ProfileCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<InstockproductsCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<OutofstockproductsCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<UpdateProductCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<SingleProductCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl<OrderCubit>(),
        ),
      ],
      child: AppView(),
    );
  }
}
