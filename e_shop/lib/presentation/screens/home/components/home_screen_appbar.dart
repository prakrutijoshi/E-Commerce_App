import 'package:flutter/material.dart';

import '../../Cart/cart_screen.dart';
import '../../WishList/wishlist_screen.dart';
import 'iconbtnwithcounter.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
