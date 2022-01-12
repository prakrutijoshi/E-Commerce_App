import '../Profile/cubit/profile_cubit.dart';
import '../../../utils/pages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          title: Text("e-Shop Seller"),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
        ),
        body: pages[pageIndex],
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: kPrimaryColor,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/Shop Icon.svg",
                        color:
                            pageIndex == 0 ? kPrimaryColor : inActiveIconColor,
                      ),
                      onPressed: () {
                        setState(() {
                          pageIndex = 0;
                        });
                      }),
                  IconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/Bell.svg",
                      color: pageIndex == 1 ? kPrimaryColor : inActiveIconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/User Icon.svg",
                      color: pageIndex == 2 ? kPrimaryColor : inActiveIconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        BlocProvider.of<ProfileCubit>(context).getSeller();
                        pageIndex = 2;
                      });
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
