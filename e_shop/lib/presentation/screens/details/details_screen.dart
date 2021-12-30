import 'package:e_shop/data/model/product_model.dart';
import 'package:e_shop/presentation/screens/details/components/body.dart';
import 'package:e_shop/presentation/screens/details/components/custom_appbar.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: product.rating),
      ),
      body: Body(product: product),
    );
  }
}
