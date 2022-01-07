import 'package:flutter/material.dart';

import '../../../data/model/product_model.dart';
import 'components/body.dart';
import 'components/custom_appbar.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.product,
    required this.isWishListed,
  }) : super(key: key);

  final ProductModel product;
  final bool isWishListed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: product.rating),
      ),
      body: Body(product: product, isWishListed: isWishListed),
    );
  }
}
