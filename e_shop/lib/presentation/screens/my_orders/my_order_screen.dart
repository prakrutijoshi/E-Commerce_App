import 'components/my_order_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/order_model.dart';
import '../../widgets/constants.dart';
import 'components/order_model_card.dart';
import 'cubit/my_order_cubit.dart';

class MyOrderScreen extends StatefulWidget {
  final bool showAppBar;

  const MyOrderScreen({
    Key? key,
    required this.showAppBar,
  }) : super(key: key);

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  bool get showAppBar => widget.showAppBar;

  @override
  void initState() {
    BlocProvider.of<MyOrderCubit>(context).getOrders();

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
        appBar: MyOrderAppBar(
          showAppBar: showAppBar,
        ),
        body: BlocBuilder<MyOrderCubit, MyOrderState>(
          builder: (context, state) {
            if (state is MyOrderInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MyOrdersLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MyOrdersLoaded) {
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
            } else if (state is MyOrdersFailure) {
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
          Tab(text: "In Process"),
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
