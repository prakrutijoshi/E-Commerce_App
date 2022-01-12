import 'package:e_shop/presentation/screens/my_orders/cubit/my_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/pages.dart';
import '../../widgets/constants.dart';
import '../profile/cubit/profile_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  final Color inActiveIconColor = Color(0xFFB6B6B6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: appBars[pageIndex],
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -3),
              blurRadius: 20,
              color: (Colors.deepPurple[300])!,
            ),
          ],
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        child: SafeArea(
          top: false,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: pageIndex == 0 ? kPrimaryColor : inActiveIconColor,
                ),
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                }),
            IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Parcel.svg",
                  color: pageIndex == 1 ? kPrimaryColor : inActiveIconColor,
                ),
                onPressed: () {
                  BlocProvider.of<MyOrderCubit>(context).getOrders();
                  setState(() {
                    pageIndex = 1;
                  });
                }),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: pageIndex == 2 ? kPrimaryColor : inActiveIconColor,
              ),
              onPressed: () {
                setState(() {
                  BlocProvider.of<ProfileCubit>(context).getUser();
                  pageIndex = 2;
                });
              },
            ),
          ]),
        ),
      ),
    );
  }
}
