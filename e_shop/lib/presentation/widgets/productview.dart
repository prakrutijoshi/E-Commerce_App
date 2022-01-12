import 'size_config.dart';

import '../screens/WishList/cubit/wishlist_cubit.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/product_model.dart';
import '../screens/details/details_screen.dart';

Widget productView(
  BuildContext context,
  List<ProductModel> productDetails,
) {
  if (productDetails.isNotEmpty)
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 3),
      child: GridView.count(
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          productDetails.length,
          (index) {
            return InkWell(
              onTap: () async {
                bool isWishListed =
                    await BlocProvider.of<WishlistCubit>(context)
                        .isExistsInWishList(productDetails[index].pid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      product: productDetails[index],
                      isWishListed: isWishListed,
                    ),
                  ),
                );
              },
              splashColor: Colors.grey,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(
                        productDetails[index].images[0],
                        height: getProportionateScreenHeight(220),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productDetails[index].name,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₹${productDetails[index].price}",
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  productDetails[index].rating,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  else
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: getProportionateScreenHeight(300)),
        child: Text(
          'We could not find any products',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
}
