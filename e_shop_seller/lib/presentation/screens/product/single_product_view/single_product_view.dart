import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/product_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/default_button.dart';
import '../../../../utils/dialog.dart';
import '../../../../utils/size_config.dart';
import '../update_product/update_product_screen.dart';
import 'components/custom_app_bar.dart';
import 'cubit/single_product_cubit.dart';

class SingleProductView extends StatefulWidget {
  final ProductModel product;

  const SingleProductView({Key? key, required this.product}) : super(key: key);

  @override
  _SingleProductViewState createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  ProductModel get product => widget.product;
  int selectedImage = 0;

  Future<void> onDeleteProduct() async {
    UtilDialog.showConfirmation(
      context,
      title: "Are you sure you want to DELETE this product?",
      onYesPressed: () async {
        await BlocProvider.of<SingleProductCubit>(context)
            .deleteSingleProduct(product.pid);

        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(rating: product.rating),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(300),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Hero(
                      tag: product.pid.toString(),
                      child: Image.network(product.images[selectedImage]),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      product.images.length,
                      (index) => buildSmallProductPreview(index: index),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: getProportionateScreenWidth(20)),
              padding: EdgeInsets.only(top: getProportionateScreenWidth(20)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Current Price: ",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextSpan(
                          text: "₹${product.price}",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "In Stock Quantity: ",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextSpan(
                          text: product.quantity,
                          style: TextStyle(
                            color: product.quantity != "0"
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(64),
                    ),
                    child: ExpandableText(
                      product.description,
                      expandText: "See More Detail",
                      collapseText: "See Less Details",
                      linkStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                      maxLines: 3,
                      animation: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: DefaultButton(
                      text: "Update Product",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                UpdateProductScreen(product: product),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: DefaultButton(
                      text: "Delete Product",
                      press: onDeleteProduct,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildSmallProductPreview({required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(5),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0),
          ),
        ),
        child: Image.network(product.images[index]),
      ),
    );
  }
}
