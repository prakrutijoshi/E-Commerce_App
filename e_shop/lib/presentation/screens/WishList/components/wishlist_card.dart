import '../../../../data/model/cart_item_model.dart';
import '../../../../data/model/product_model.dart';
import '../../../../data/model/wishlist_item_model.dart';
import '../../Cart/cubit/cart_cubit.dart';
import '../cubit/wishlist_cubit.dart';
import '../../details/details_screen.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../../../utils/dialog.dart';
import '../../../../utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishListCard extends StatelessWidget {
  final WishListItemModel wishlistItem;

  const WishListCard({Key? key, required this.wishlistItem}) : super(key: key);

  Future<void> onAddToCart(BuildContext context) async {
    CartItemModel newCartItem = CartItemModel(
      cid: wishlistItem.wid,
      productId: wishlistItem.productId,
      price: wishlistItem.price,
      quantity: "1",
    );

    await BlocProvider.of<CartCubit>(context).addCartItem(newCartItem);
    UtilToast.showMessageForUser(context, "Added to cart successfully");
  }

  Future<void> removeFromWishList(BuildContext context) async {
    await BlocProvider.of<WishlistCubit>(context)
        .removeWishListItem(wishlistItem);
  }

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
                          .isExistsInWishList(wishlistItem.productId);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        product: wishlistItem.productInfo as ProductModel,
                        isWishListed: isWishListed,
                      ),
                    ),
                  );
                },
                child: Image.network(
                  wishlistItem.productInfo!.images[0],
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
                                .isExistsInWishList(wishlistItem.productId);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              product: wishlistItem.productInfo as ProductModel,
                              isWishListed: isWishListed,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        wishlistItem.productInfo!.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: kSecondaryColor),
                      child: Text(
                        "₹ ${wishlistItem.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: kPrimaryColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(
                        height: 0,
                        thickness: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _onRemoveItem(context);
                            },
                            icon: SvgPicture.asset(
                              "assets/icons/Trash.svg",
                              color: Colors.red,
                            ),
                            label: Text(
                              "Remove",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: getProportionateScreenWidth(12)),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              onAddToCart(context);
                              removeFromWishList(context);
                            },
                            icon: SvgPicture.asset(
                              "assets/icons/Cart Icon.svg",
                              color: Colors.green,
                            ),
                            label: Text(
                              "Add to Cart",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: getProportionateScreenWidth(12)),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onRemoveItem(BuildContext context) async {
    final response = await UtilDialog.showConfirmation(
      context,
      title: "Remove Item",
      content: Text("Are you sure you want to remove this item?"),
      confirmButtonText: "Remove",
    ) as bool;

    if (response) {
      WishListItemModel deleteWishListItem = wishlistItem;

      // remove cart item
      await BlocProvider.of<WishlistCubit>(context)
          .removeWishListItem(deleteWishListItem);

      UtilToast.showMessageForUser(context, "1 Item removed");
    }
  }
}
