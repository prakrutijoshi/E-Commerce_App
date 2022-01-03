import 'package:flutter/material.dart';

import '../../../utils/customnavbar.dart';
import '../../../utils/enum.dart';
import '../Cart/cart_screen.dart';
import 'components/body.dart';
import 'components/iconbtnwithcounter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
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
