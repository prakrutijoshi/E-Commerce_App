import '../cubit/category_cubit.dart';
import '../../../widgets/productview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.categoryname})
      : super(key: key);

  final String categoryname;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryCubit>(context)
        .findProductByCategory(category: widget.categoryname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryname),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          print(state);
          if (state is CategoryInitial) {
            BlocProvider.of<CategoryCubit>(context)
                .findProductByCategory(category: widget.categoryname);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryLoaded) {
            return productView(context, state.products);
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
    );
  }
}
