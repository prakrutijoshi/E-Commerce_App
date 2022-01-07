import 'package:e_shop/presentation/screens/WishList/components/body.dart';
import 'package:e_shop/presentation/screens/WishList/cubit/wishlist_cubit.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
