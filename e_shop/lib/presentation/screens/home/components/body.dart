import 'package:e_shop/presentation/screens/home/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/size_config.dart';
import 'categories.dart';
import 'discountbanner.dart';
import 'products.dart';
import 'searchfield.dart';
import 'specialoffers.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _scrollController = ScrollController();
  void initState() {
    super.initState();
    setupscrollcontroller(context);
  }

  void setupscrollcontroller(
    BuildContext context,
  ) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          BlocProvider.of<ProductCubit>(context).fetchProducts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().initState(context);
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            SearchField(),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            Products(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
