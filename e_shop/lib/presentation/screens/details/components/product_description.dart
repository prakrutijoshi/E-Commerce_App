import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/model/product_model.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Price: ",
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
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              // color:
              //     product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Heart Icon_2.svg",
              height: getProportionateScreenWidth(16),
            ),
          ),
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
      ],
    );
  }
}
