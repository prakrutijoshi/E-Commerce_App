import 'package:e_shop/data/model/wishlist_item_model.dart';
import 'package:e_shop/presentation/screens/WishList/cubit/wishlist_cubit.dart';
import 'package:e_shop/utils/dialog.dart';
import 'package:e_shop/utils/toast.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/model/product_model.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';

class ProductDescription extends StatefulWidget {
  ProductDescription({
    Key? key,
    required this.product,
    required this.isWishListed,
  }) : super(key: key);

  final ProductModel product;
  bool isWishListed;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  // get isWishListed => widget.isWishListed;

  // wishlisted() async {
  //   return await BlocProvider.of<WishlistCubit>(context)
  //       .isExistsInWishList(widget.product.pid);
  // }

  Future<void> onAddToWishList(BuildContext context) async {
    WishListItemModel newWishlistItem = WishListItemModel(
      wid: widget.product.pid,
      productId: widget.product.pid,
      price: widget.product.price,
    );

    UtilDialog.showWaiting(context);

    await BlocProvider.of<WishlistCubit>(context)
        .addWishListItem(newWishlistItem);

    UtilDialog.hideWaiting(context);
    UtilToast.showMessageForUser(context, "Added to WishList");
  }

  Future<void> onRemoveFromWishList(BuildContext context) async {
    WishListItemModel deleteWishListItem = WishListItemModel(
      wid: widget.product.pid,
      productId: widget.product.pid,
      price: widget.product.price,
    );

    UtilDialog.showWaiting(context);

    await BlocProvider.of<WishlistCubit>(context)
        .removeWishListItem(deleteWishListItem);

    UtilDialog.hideWaiting(context);
    UtilToast.showMessageForUser(context, "Removed from WishList");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            widget.product.name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Price: ",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    TextSpan(
                      text: "₹${widget.product.price}",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(
                  () => widget.isWishListed = !widget.isWishListed,
                );
                widget.isWishListed
                    ? onAddToWishList(context)
                    : onRemoveFromWishList(context);
              },
              icon: widget.isWishListed
                  ? SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: Colors.red,
                    )
                  : SvgPicture.asset(
                      "assets/icons/Heart Icon.svg",
                    ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: ExpandableText(
            widget.product.description,
            expandText: "See More Detail",
            collapseText: "See Less Details",
            linkStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
            maxLines: 3,
            animation: true,
          ),
        ),
      ],
    );
  }
}
