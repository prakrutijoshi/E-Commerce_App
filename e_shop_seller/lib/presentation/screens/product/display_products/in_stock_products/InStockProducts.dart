import '../../single_product_view/single_product_view.dart';

import 'cubit/instockproducts_cubit.dart';

import '../../../../../data/models/product_model.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InStockProducts extends StatefulWidget {
  const InStockProducts({Key? key}) : super(key: key);

  @override
  _InStockProductsState createState() => _InStockProductsState();
}

class _InStockProductsState extends State<InStockProducts> {
  ScrollController _scrollController = ScrollController();
  void initState() {
    super.initState();
    BlocProvider.of<InstockproductsCubit>(context)
        .getAvailableProductsBySeller();
    setupscrollcontroller(context);
  }

  void setupscrollcontroller(
    BuildContext context,
  ) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          BlocProvider.of<InstockproductsCubit>(context)
              .getAvailableProductsBySeller();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          BlocProvider.of<InstockproductsCubit>(context).page = 1;
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("In Stock Products"),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
          ),
          body: BlocBuilder<InstockproductsCubit, InstockproductsState>(
            builder: (context, state) {
              if (state is InstockproductsInitial) {
                // BlocProvider.of<InstockproductsCubit>(context)
                //     .getAvailableProductsBySeller();
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is InstockproductsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is InstockproductsLoaded) {
                return availableProductsView(state.products);
              } else if (state is InstockproductsError) {
                return UtilDialog.showInformation(context,
                    title: state.message);
              } else {
                return Center(
                  child: Text("Something went wrong !!!"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget availableProductsView(List<ProductModel> products) {
    return products.isEmpty
        ? Center(
            child: Text("There are no Products in here"),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: GridView.count(
              controller: _scrollController,
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
