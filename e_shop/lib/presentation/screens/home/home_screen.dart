import 'package:e_shop/presentation/screens/Cart/cart_screen.dart';
import 'package:e_shop/presentation/screens/home/components/body.dart';
import 'package:e_shop/presentation/screens/home/components/customnavbar.dart';
import 'package:e_shop/presentation/screens/home/components/iconbtnwithcounter.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/utils/enum.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  //final User currentUser;

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("e-Shop"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        actions: [
          IconBtnWithCounter(
            svgSrc: "assets/icons/Heart Icon.svg",
            color: Colors.white,
            press: () {},
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
      body: Body(),
      bottomNavigationBar: CustomNavBar(selected: Menu.home),
    );
  }
}
