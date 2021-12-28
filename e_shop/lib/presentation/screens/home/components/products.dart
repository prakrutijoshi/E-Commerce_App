import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/data/model/product_model.dart';
import 'package:e_shop/presentation/screens/home/cubit/product_cubit.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Products extends StatefulWidget {
  Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
          return productView(state.productDetails);
        } else {
          return Center(
            child: Text("Something went wrong !!!"),
          );
        }
      },
    );
  }

  Widget productView(List<ProductModel> productDetails) {
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
        productDetails.length,
        (index) {
          return Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  productDetails[index].images[0],
                  height: getProportionateScreenHeight(30),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  productDetails[index].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Rs. ${productDetails[index].price}',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.favorite_border)),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      label: Text('Add to Cart'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}