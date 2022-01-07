import 'package:e_shop/presentation/widgets/constants.dart';

import 'components/checkout_button.dart';
import 'cubit/cart_cubit.dart';
import '../../../utils/dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Body(),
        backgroundColor: kSecondaryColor,
        bottomNavigationBar: CheckOutButton(),
        // bottomNavigationBar: _buildOrderNowButton(context),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Text("Your Cart"),
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(Icons.clear_all_rounded),
        onPressed: () => _onClearCart(context),
      )
    ],
  );
}

_onClearCart(BuildContext context) async {
  final response = await UtilDialog.showConfirmation(
    context,
    title: "Clear Cart",
    content: Text("All cart items will be deleted from your cart"),
    confirmButtonText: "Delete",
  ) as bool;

  if (response) {
    await BlocProvider.of<CartCubit>(context).clearCart();
  }
}

// _buildOrderNowButton(context) {
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
//     child: Padding(
//       padding: const EdgeInsets.all(30.0),
//       child: DefaultButton(
//         text: "Order Now",
//         press: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => CheckoutScreen()));
//         },
//       ),
//     ),
//   );
// }
