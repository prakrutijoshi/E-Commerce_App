import '../../../../data/models/product_model.dart';
import 'cubit/update_product_cubit.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/default_button.dart';
import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModel product;

  const UpdateProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  ProductModel get product => widget.product;

  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityActionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  late String dropdownValue;
  late String quantityActionValue = "Quantity Increase";

  @override
  void initState() {
    super.initState();

    dropdownValue = product.category;
    productNameController.text = product.name;
    descriptionController.text = product.description;
    quantityActionController.text = "0";
    priceController.text = product.price;
  }

  bool get isPopulated =>
      dropdownValue.trim().isNotEmpty &&
      productNameController.text.trim().isNotEmpty &&
      descriptionController.text.trim().isNotEmpty &&
      quantityActionController.text.trim().isNotEmpty &&
      priceController.text.trim().isNotEmpty;

  bool get isQuantityActionValid => quantityActionValue == "Quantity Decrease"
      ? int.parse(product.quantity) >=
              int.parse(quantityActionController.text.trim())
          ? true
          : false
      : true;

  Future<void> onUpdateProduct() async {
    if (isQuantityActionValid) {
      if (isPopulated) {
        int updatedQuantity = quantityActionValue == "Quantity Increase"
            ? int.parse(product.quantity) +
                int.parse(quantityActionController.text.trim())
            : int.parse(product.quantity) -
                int.parse(quantityActionController.text.trim());

        var updatedProduct = product.cloneWith(
          name: productNameController.text.trim(),
          description: descriptionController.text.trim(),
          category: dropdownValue.trim(),
          quantity: updatedQuantity.toString(),
          price: priceController.text.trim(),
          isAvailable: updatedQuantity > 0 ? true : false,
        );

        await BlocProvider.of<UpdateProductCubit>(context)
            .updateProduct(updatedProduct: updatedProduct);

        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        UtilDialog.showInformation(
          context,
          content: "Either some fileds are empty or somthing went wrong",
        );
      }
    } else {
      UtilDialog.showInformation(
        context,
        content: "Entered Decrement Quantity amount is not valid",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Product"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: BlocListener<UpdateProductCubit, UpdateProductState>(
            listener: (context, state) {
              if (state is ProductUpdating) {
                UtilDialog.showWaiting(context);
              }

              if (state is UpdateProductDone) {
                UtilDialog.hideWaiting(context);
              }

              if (state is UpdateProductError) {
                UtilDialog.hideWaiting(context);
                UtilDialog.showInformation(context, content: state.message);
              }
            },
            child: BlocBuilder<UpdateProductCubit, UpdateProductState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildInput(),
                    _buildUpdateButton(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildInput() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(height: 30),
            // category input
            DropdownButtonFormField<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down_circle),
              elevation: 16,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: "Category",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: categoryList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            // Product name input
            TextFormField(
              controller: productNameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Product Name",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: 20),
            // Description input
            TextFormField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: 20),

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
                      color:
                          product.quantity != "0" ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: quantityActionValue,
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      quantityActionValue = newValue!;
                    });
                  },
                  items: ["Quantity Increase", "Quantity Decrease"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),

            SizedBox(height: 10),

            // Quantity input
            TextFormField(
              controller: quantityActionController,
              keyboardType: TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: "$quantityActionValue by",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: 20),
            // Price input
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: "Price",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  _buildUpdateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: DefaultButton(
        text: "Confirm Update",
        press: onUpdateProduct,
      ),
    );
  }
}
