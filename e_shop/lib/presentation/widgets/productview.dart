import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../data/model/product_model.dart';
import '../screens/details/details_screen.dart';

Widget productView(BuildContext context, List<ProductModel> productDetails) {
  if (productDetails.isNotEmpty)
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          productDetails.length,
          (index) {
            return InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      product: productDetails[index],
                    ),
                  ),
                ),
              },
              splashColor: Colors.grey,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      productDetails[index].images[0],
                      height: 250,
                      fit: BoxFit.cover,
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
      child: Text(
        'We could not find any products',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
        textAlign: TextAlign.center,
      ),
    );
}
