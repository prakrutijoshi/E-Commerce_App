import 'package:flutter/material.dart';

import '../../../../data/model/product_model.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';

class ProductImages extends StatefulWidget {
  ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(300),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.pid.toString(),
              child: Image.network(widget.product.images[selectedImage]),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              widget.product.images.length,
              (index) => buildSmallProductPreview(index),
            ),
          ],
        ),
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0),
          ),
        ),
        child: Image.network(widget.product.images[index]),
      ),
    );
  }
}
