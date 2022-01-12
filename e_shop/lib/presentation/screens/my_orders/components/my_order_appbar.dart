import 'package:flutter/material.dart';

import '../../../widgets/constants.dart';

class MyOrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showAppBar;

  const MyOrderAppBar({
    Key? key,
    required this.showAppBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showAppBar) {
      return AppBar(
        title: Text("My Orders"),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      );
    } else {
      return Container();
    }
  }

  @override
  Size get preferredSize {
    if (showAppBar) {
      return Size.fromHeight(kToolbarHeight);
    } else {
      return Size.fromHeight(0);
    }
  }
}
