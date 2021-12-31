import '../../single_product_view/single_product_view.dart';

import '../../../../../data/models/product_model.dart';
import 'cubit/outofstockproducts_cubit.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutOfStockProducts extends StatefulWidget {
  const OutOfStockProducts({Key? key}) : super(key: key);

  @override
  _OutOfStockProductsState createState() => _OutOfStockProductsState();
}

class _OutOfStockProductsState extends State<OutOfStockProducts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Out of Stock Products"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: BlocBuilder<OutofstockproductsCubit, OutofstockproductsState>(
          builder: (context, state) {
            if (state is OutofstockproductsInitial) {
              BlocProvider.of<OutofstockproductsCubit>(context)
                  .getUnAvailableProductsBySeller();
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OutofstockproductsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OutofstockproductsLoaded) {
              return unAvailableProductsView(state.products);
            } else if (state is OutofstockproductsError) {
              return UtilDialog.showInformation(context, title: state.message);
            } else {
              return Center(
                child: Text("Something went wrong !!!"),
              );
            }
          },
        ),
      ),
    );
  }

  Widget unAvailableProductsView(List<ProductModel> products) {
    return products.isEmpty
        ? Center(
            child: Text("There are no Products in here"),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.58,
              children: List.generate(
                products.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SingleProductView(product: products[index]),
                        ),
                      );
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
                            products[index].images[0],
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].name,
                                  maxLines: 1,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "₹${products[index].price}",
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
                                        products[index].rating,
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
