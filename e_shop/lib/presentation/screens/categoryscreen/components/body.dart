import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/productview.dart';
import '../cubit/category_cubit.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.categoryname})
      : super(key: key);

  final String categoryname;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CategoryCubit>(context)
        .findProductByCategory(category: widget.categoryname);
    setupscrollcontroller(context);
  }

  void setupscrollcontroller(
    BuildContext context,
  ) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          BlocProvider.of<CategoryCubit>(context)
              .findProductByCategory(category: widget.categoryname);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<CategoryCubit>(context).page = 1;
        return true;
      },
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          title: Text(widget.categoryname),
          centerTitle: true,
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryInitial) {
              // BlocProvider.of<CategoryCubit>(context)
              //     .findProductByCategory(category: widget.categoryname);
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryLoaded) {
              return SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: productView(context, state.products),
                  ));
            } else if (state is CategoryError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text("Something went wrong !!!"),
              );
            }
          },
        ),
      ),
    );
  }
}
