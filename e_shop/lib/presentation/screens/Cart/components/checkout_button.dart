import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/default_button.dart';
import '../../../widgets/constants.dart';
import '../../Checkout/checkout_screen.dart';
import '../cubit/cart_cubit.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -0.5),
              color: Colors.black12,
              blurRadius: 5,
            )
          ],
        ),
        child: BlocBuilder<CartCubit, CartState>(
          buildWhen: (preState, currState) => currState is CartLoaded,
          builder: (context, state) {
            if (state is CartLoaded && state.cartList.isNotEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTotalPrice(context, state),
                  SizedBox(height: 10),
                  _buildCheckoutButton(context, state),
                ],
              );
            } else {
              return Container(
                height: 0,
                width: 0,
              );
            }
          },
        ),
      ),
    );
  }

  _buildTotalPrice(BuildContext context, CartLoaded state) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: SvgPicture.asset(
            "assets/icons/receipt.svg",
            width: 20,
            height: 20,
          ),
        ),
        SizedBox(width: 5),
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18,
            ),
            children: [
              TextSpan(text: "Total:\n"),
              TextSpan(
                text: "₹${state.priceOfGoods.toString()}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildCheckoutButton(BuildContext context, CartLoaded state) {
    return DefaultButton(
      text: "CheckOut",
      press: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutScreen(
            priceOfGoods: state.priceOfGoods,
          ),
        ),
      ),
    );
  }
}
