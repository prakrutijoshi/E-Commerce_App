import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/dialog.dart';
import '../../widgets/constants.dart';
import 'components/body.dart';
import 'cubit/wishlist_cubit.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("WishList"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _onClear(context),
              icon: Icon(Icons.clear_all_rounded)),
        ],
      ),
      body: Body(),
    );
  }
}

_onClear(BuildContext context) async {
  final response = await UtilDialog.showConfirmation(
    context,
    title: "Clear WishList",
    content: Text("All your wishlisted products will be deleted"),
  ) as bool;

  if (response) {
    await BlocProvider.of<WishlistCubit>(context).clearWishList();
  }
}
