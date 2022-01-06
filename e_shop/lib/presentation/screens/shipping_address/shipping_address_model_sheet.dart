import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/shipping_address_model.dart';
import '../../../utils/default_button.dart';
import '../../../utils/utils.dart';
import '../../widgets/constants.dart';
import '../../widgets/size_config.dart';
import 'cubit/address_cubit.dart';

class ShippingAddressModelSheet extends StatefulWidget {
  final ShippingAddressModel? shippingAddress;

  const ShippingAddressModelSheet({Key? key, this.shippingAddress})
      : super(key: key);

  @override
  _ShippingAddressModelSheetState createState() =>
      _ShippingAddressModelSheetState();
}

class _ShippingAddressModelSheetState extends State<ShippingAddressModelSheet> {
  ShippingAddressModel? get shippingAddress => widget.shippingAddress;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  bool isDefaultAddress = true;

  @override
  void initState() {
    super.initState();

    if (shippingAddress != null) {
      fullNameController.text = shippingAddress!.fullName;
      phoneNumberController.text = shippingAddress!.phoneNumber;
      detailAddressController.text = shippingAddress!.detailedAddress;
      cityController.text = shippingAddress!.city;
      stateController.text = shippingAddress!.state;
      postalController.text = shippingAddress!.postal;
      countryController.text = shippingAddress!.country;
      isDefaultAddress = shippingAddress!.isDefault;
    }
  }

  bool get isPopulated =>
      fullNameController.text.trim().isNotEmpty &&
      phoneNumberController.text.trim().isNotEmpty &&
      detailAddressController.text.trim().isNotEmpty &&
      cityController.text.trim().isNotEmpty &&
      stateController.text.trim().isNotEmpty &&
      postalController.text.trim().isNotEmpty &&
      countryController.text.trim().isNotEmpty;

  Function(bool value)? onSwitchButtonChanged() {
    return shippingAddress == null || shippingAddress!.isDefault
        ? null
        : (value) => setState(() => isDefaultAddress = value);
  }

  Future<void> onSubmitAddress() async {
    if (isPopulated) {
      // Create new delivery address
      var newAddress = ShippingAddressModel(
        aid: shippingAddress != null
            ? shippingAddress!.aid
            : UniqueKey().toString(),
        fullName: fullNameController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        detailedAddress: detailAddressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        postal: postalController.text.trim(),
        country: countryController.text.trim(),
        isDefault: isDefaultAddress,
      );

      // Define method submit
      var _method =
          shippingAddress == null ? ListMethod.ADD : ListMethod.UPDATE;
      // Call cubit method to add or update address
      BlocProvider.of<AddressCubit>(context).addUpdateDeleteAddress(
        shippingAddress: newAddress,
        method: _method,
      );

      Navigator.pop(context);
    } else {
      UtilDialog.showInformation(
        context,
        content: "You need to complete all fields",
      );
    }
  }

  void onRemoveAddress() {
    BlocProvider.of<AddressCubit>(context).addUpdateDeleteAddress(
      shippingAddress: shippingAddress!,
      method: ListMethod.DELETE,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          title: Text("Address Sheet"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildInput(),
                _buildSwitchDefaultAddress(),
                _buildDeleteButton(),
                _buildSubmitButton(),
              ],
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
            // Name input
            TextFormField(
              controller: fullNameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(12)),
            // Phone number input
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(12)),

            TextFormField(
              controller: detailAddressController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Address",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
              maxLines: null,
            ),

            SizedBox(height: getProportionateScreenHeight(12)),

            TextFormField(
              controller: cityController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "City",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(12)),

            TextFormField(
              controller: stateController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "State",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(12)),

            TextFormField(
              controller: postalController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Poatal",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(12)),

            TextFormField(
              controller: countryController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Country",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(12)),
          ],
        ),
      ),
    );
  }

  _buildSwitchDefaultAddress() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Put this as default address",
            ),
            Switch(
              value: isDefaultAddress,
              onChanged: onSwitchButtonChanged(),
            ),
          ],
        ),
      ),
    );
  }

  _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 30,
      ),
      child: DefaultButton(
        text: "confirm",
        press: onSubmitAddress,
      ),
    );
  }

  _buildDeleteButton() {
    return shippingAddress != null && !shippingAddress!.isDefault
        ? Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: DefaultButton(
              press: onRemoveAddress,
              text: "delete",
            ),
          )
        : Container();
  }
}
