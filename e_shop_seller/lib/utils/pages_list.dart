import 'package:flutter/material.dart';

import '../presentation/screens/Profile/components/profile_appbar.dart';
import '../presentation/screens/Profile/profile_screen.dart';
import '../presentation/screens/home/components/home_appbar.dart';
import '../presentation/screens/home/components/home_screen_body.dart';
import '../presentation/screens/orders/components/order_appbar.dart';
import '../presentation/screens/orders/order_screen.dart';

final pages = [
  HomeScreenBody(),
  OrderScreen(
    showAppBar: false,
  ),
  ProfileScreen(),
];

final List<PreferredSizeWidget> appBars = [
  HomeAppBar(),
  OrderAppBar(
    showAppBar: true,
  ),
  ProfileAppBar(),
];
