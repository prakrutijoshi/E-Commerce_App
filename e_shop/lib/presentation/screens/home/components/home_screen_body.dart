import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/size_config.dart';
import '../cubit/product_cubit.dart';
import 'categories.dart';
import 'discountbanner.dart';
import 'products.dart';
import 'searchfield.dart';
import 'specialoffers.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
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
              height: getProportionateScreenWidth(10),
            ),
            Products(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
