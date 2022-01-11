import '../../WishList/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/model/cart_item_model.dart';
import '../../../../data/model/product_model.dart';
import '../../../../utils/dialog.dart';
import '../../../../utils/toast.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../details/details_screen.dart';
import '../cubit/cart_cubit.dart';
import 'circular_icon_button.dart';

class CartCard extends StatelessWidget {
  final CartItemModel cartItem;

  const CartCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(5),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  bool isWishListed =
                      await BlocProvider.of<WishlistCubit>(context)
                          .isExistsInWishList(cartItem.productId);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        product: cartItem.productInfo as ProductModel,
                        isWishListed: isWishListed,
                      ),
                    ),
                  );
                },
                child: Image.network(
                  cartItem.productInfo!.images[0],
                  width: 90,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        bool isWishListed =
                            await BlocProvider.of<WishlistCubit>(context)
                                .isExistsInWishList(cartItem.productId);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              product: cartItem.productInfo as ProductModel,
                              isWishListed: isWishListed,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        cartItem.productInfo!.name,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: kSecondaryColor,
                          ),
                          child: Text(
                            "₹ ${cartItem.price}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        CircleIconButton(
                          icon: Icons.remove,
                          onPressed: () {
                            _onQuantityDecrease(context);
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: kSecondaryColor,
                          ),
                          child: Text(
                            "Qty: ${cartItem.quantity}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        CircleIconButton(
                          icon: Icons.add,
                          onPressed: () {
                            _onQuantityIncrease(context);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(
              height: 0,
              thickness: 1,
            ),
          ),
          ElevatedButton.icon(
            icon: SvgPicture.asset("assets/icons/Trash.svg"),
            onPressed: () {
              _onRemoveCartItem(context);
            },
            label: Text(
              "Remove",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: getProportionateScreenWidth(18)),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onQuantityIncrease(BuildContext context) {
    var currentCartQuantity = int.parse(cartItem.quantity);
    var productAvailableQuantity = int.parse(cartItem.productInfo!.quantity);

    if (currentCartQuantity < productAvailableQuantity &&
        currentCartQuantity < 10) {
      UtilDialog.showWaiting(context);

      _onChangeQuantity(
        context,
        currentCartQuantity + 1,
      );
    } else {
      UtilToast.showMessageForUser(context, "Quantity limit reached");
    }
  }

  _onQuantityDecrease(BuildContext context) {
    var currentCartQuantity = int.parse(cartItem.quantity);

    if (currentCartQuantity > 1) {
      UtilDialog.showWaiting(context);

      _onChangeQuantity(
        context,
        currentCartQuantity - 1,
      );
    } else {
      UtilToast.showMessageForUser(context, "Can't decrease");
    }
  }

  _onChangeQuantity(BuildContext context, int newQuantity) async {
    CartItemModel updateCartItem = cartItem.cloneWith(
      quantity: newQuantity.toString(),
      price: (newQuantity * int.parse(cartItem.productInfo!.price)).toString(),
    );

    // update cart item
    await BlocProvider.of<CartCubit>(context).updateCartItem(updateCartItem);

    UtilDialog.hideWaiting(context);
  }

  _onRemoveCartItem(BuildContext context) async {
    final response = await UtilDialog.showConfirmation(
      context,
      title: "Remove Item",
      content: Text("Are you sure you want to remove this item?"),
      confirmButtonText: "Remove",
    ) as bool;

    if (response) {
      CartItemModel deleteCartItem = cartItem;

      // remove cart item
      await BlocProvider.of<CartCubit>(context).removeCartItem(deleteCartItem);

      UtilToast.showMessageForUser(context, "1 Item removed");
    }
  }
}
