import 'components/shipping_address_card.dart';
import 'shipping_address_model_sheet.dart';
import '../../widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/shipping_address_model.dart';
import 'cubit/address_cubit.dart';

class ShippingAddressScreen extends StatelessWidget {
  final bool? showDefaultTick;

  const ShippingAddressScreen({
    Key? key,
    this.showDefaultTick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(
            'Shipping Address',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 5,
        ),
        body: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is AddressInitial || state is AddressUpdated) {
              BlocProvider.of<AddressCubit>(context).getAddresses();
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AddressLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AddressLoaded) {
              var addressList = state.addresses;
              return addressList.isNotEmpty
                  ? _shippingAddressView(addressList)
                  : _buildNoAddress(context);
            } else {
              print(state.toString());
              return Center(
                child: Text("Couldn't load data"),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShippingAddressModelSheet(),
              ),
            );
          },
          label: Text(
            'ADD NEW ADDRESS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          icon: Icon(Icons.add),
          backgroundColor: kPrimaryColor,
        ),
      ),
    );
  }

  Widget _shippingAddressView(List<ShippingAddressModel> addresses) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        return ShippingAddressCard(
          shippingAddress: addresses[index],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShippingAddressModelSheet(
                  shippingAddress: addresses[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

_buildNoAddress(BuildContext context) {
  return Center(
    child: Text("Click below button and add new address"),
  );
}
