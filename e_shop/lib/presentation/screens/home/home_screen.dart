import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/pages.dart';
import '../../widgets/constants.dart';
import '../Cart/cart_screen.dart';
import '../WishList/wishlist_screen.dart';
import '../profile/cubit/profile_cubit.dart';
import 'components/iconbtnwithcounter.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("e-Shop"),
        centerTitle: true,
        actions: [
          IconBtnWithCounter(
            svgSrc: "assets/icons/Heart Icon.svg",
            color: Colors.white,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishListScreen()),
              );
            },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            color: Colors.white,
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: pages[pageIndex],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(40),
          //   topRight: Radius.circular(40),
          //   bottomLeft: Radius.circular(40),
          //   bottomRight: Radius.circular(40),
          // ),
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
                  setState(() {
                    pageIndex = 1;
                  });
                }),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Bell.svg",
                color: pageIndex == 2 ? kPrimaryColor : inActiveIconColor,
              ),
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: pageIndex == 3 ? kPrimaryColor : inActiveIconColor,
              ),
              onPressed: () {
                setState(() {
                  BlocProvider.of<ProfileCubit>(context).getUser();
                  pageIndex = 3;
                });
              },
            ),
          ]),
        ),
      ),
    );
  }
}
