import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/order_model.dart';
import '../../../utils/constants.dart';
import 'components/order_appbar.dart';
import 'components/order_model_card.dart';
import 'cubit/order_cubit.dart';

class OrderScreen extends StatefulWidget {
  final bool showAppBar;

  const OrderScreen({
    Key? key,
    required this.showAppBar,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  bool get showAppBar => widget.showAppBar;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: OrderAppBar(
          showAppBar: showAppBar,
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrdersLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrdersLoaded) {
              return Column(
                children: <Widget>[
                  _buildTabs(),
                  SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        _buildListOrders(state.deliveringOrders),
                        _buildListOrders(state.deliveredOrders),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is OrdersFailure) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return Center(
                child: Text("Something went wrong."),
              );
            }
          },
        ),
      ),
    );
  }

  _buildTabs() {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        controller: tabController,
        tabs: <Widget>[
          Tab(text: "Delivering"),
          Tab(text: "Delivered"),
        ],
        onTap: (index) {},
        labelStyle: TextStyle(
            fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18),
        labelColor: kPrimaryColor,
        unselectedLabelColor: Color(0xFF4a4a4a),
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600, color: Colors.black, fontSize: 14),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: kPrimaryColor,
        indicatorWeight: 2,
      ),
    );
  }

  _buildListOrders(List<OrderModel> orders) {
    return orders.isEmpty
        ? Center(
            child: Text("No Orders yet here"),
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: OrderModelCard(order: orders[index]),
              );
            },
          );
  }
}
