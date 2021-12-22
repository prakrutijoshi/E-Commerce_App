import 'package:e_shop/presentation/screens/shipping_address/components/shipping_address_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_shop/data/model/shipping_address_model.dart';
import 'package:e_shop/injection_container.dart' as di;
import 'package:e_shop/presentation/screens/shipping_address/cubit/address_cubit.dart';

class ShippingAddressScreen extends StatelessWidget {
  final User currentUser;
  final bool? showDefaultTick;

  const ShippingAddressScreen({
    Key? key,
    required this.currentUser,
    this.showDefaultTick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AddressCubit>(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'Shipping Address',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          body: BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              if (state is AddressInitial) {
                BlocProvider.of<AddressCubit>(context)
                    .getAddresses(currentUser.uid);
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AddressLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AddressLoaded) {
                return shippingAddressView(state.addresses);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          // floatingActionButton: FloatingActionButton.extended(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             ShippingAddressModelBottomSheet(currentUser: currentUser),
          //       ),
          //     );
          //   },
          //   label: Text(
          //     'Add new address',
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16),
          //   ),
          //   icon: Icon(Icons.add),
          //   backgroundColor: Colors.blueAccent,
          // ),
        ),
      ),
    );
  }

  Widget shippingAddressView(List<ShippingAddressModel> addresses) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        return ShippingAddressCard(
          deliveryAddress: addresses[index],
          onPressed: () {},
        );
      },
    );
  }
}
