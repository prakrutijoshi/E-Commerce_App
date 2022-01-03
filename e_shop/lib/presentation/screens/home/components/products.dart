import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/product_model.dart';
import '../../details/details_screen.dart';
import '../cubit/product_cubit.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          BlocProvider.of<ProductCubit>(context).fetchProducts();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductLoaded) {
          return productView(context, state.productDetails);
        } else if (state is ProductError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text("Something went wrong !!!"),
          );
        }
      },
    );
  }

  Widget productView(BuildContext context, List<ProductModel> productDetails) {
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
  }
}
