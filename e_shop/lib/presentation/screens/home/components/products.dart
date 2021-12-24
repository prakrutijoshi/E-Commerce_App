import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/data/model/product_model.dart';
import 'package:e_shop/presentation/screens/home/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_shop/injection_container.dart' as di;

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Products extends StatefulWidget {
  Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late ProductModel model;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ProductCubit>(),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            BlocProvider.of<ProductCubit>(context).fetchProductUsecase();
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
      ),
    );
  }

  Widget productView(List<ProductModel> productDetails) {
    return FutureBuilder<QuerySnapshot>(
        future: _firestore.collection('users').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return SingleChildScrollView(
              child: Column(
                children: documents
                    .map(
                      (doc) => Card(
                        child: ListTile(
                          title: Text(doc['name']),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          } else {
            return Text('something wenr wrong !!!');
          }
        });
  }
}
