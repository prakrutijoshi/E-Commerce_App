import '../../../../data/model/cart_item_model.dart';
import '../../Cart/cubit/cart_cubit.dart';
import '../../../../utils/dialog.dart';
import '../../../../utils/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/product_model.dart';
import 'product_description.dart';
import 'product_images.dart';
import 'rounded_container.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../../../utils/default_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final ProductModel product;
  const Body({Key? key, required this.product}) : super(key: key);

  Future<void> onAddToCart(BuildContext context) async {
    CartItemModel newCartItem = CartItemModel(
      cid: product.pid,
      productId: product.pid,
      quantity: "1",
      price: product.price,
    );

    UtilDialog.showWaiting(context);

    await BlocProvider.of<CartCubit>(context).addCartItem(newCartItem);

    UtilDialog.hideWaiting(context);
    UtilToast.showMessageForUser(context, "Added in cart Successfully");
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        RoundedContainer(
          color: kSecondaryColor,
          child: Column(
            children: [
              ProductDescription(
                product: product,
              ),
              RoundedContainer(
                color: kSecondaryColor,
                child: Column(
                  children: [
                    RoundedContainer(
                      color: kSecondaryColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add to Cart",
                          press: int.parse(product.quantity) > 0
                              ? () {
                                  onAddToCart(context);
                                }
                              : () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
