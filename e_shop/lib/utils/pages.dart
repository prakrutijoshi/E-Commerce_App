import 'package:flutter/cupertino.dart';

import '../presentation/screens/home/components/home_screen_appbar.dart';
import '../presentation/screens/home/components/home_screen_body.dart';
import '../presentation/screens/my_orders/components/my_order_appbar.dart';
import '../presentation/screens/my_orders/my_order_screen.dart';
import '../presentation/screens/profile/components/profile_appbar.dart';
import '../presentation/screens/profile/profile_screen.dart';

final pages = [
  HomeScreenBody(),
  MyOrderScreen(
    showAppBar: false,
  ),
  ProfileScreen(),
];

final List<PreferredSizeWidget> appBars = [
  HomeScreenAppBar(),
  MyOrderAppBar(
    showAppBar: true,
  ),
  ProfileAppBar(),
];
