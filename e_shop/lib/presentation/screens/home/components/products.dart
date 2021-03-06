import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/productview.dart';
import '../cubit/product_cubit.dart';

class Products extends StatefulWidget {
  @override
  State<Products> createState() => _ProductsState();
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
}
