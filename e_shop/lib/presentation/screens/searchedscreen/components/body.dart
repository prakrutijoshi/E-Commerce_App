import 'package:e_shop/presentation/widgets/productview.dart';
import '../cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchedScreen extends StatefulWidget {
  const SearchedScreen({Key? key, required this.product}) : super(key: key);

  final String product;

  @override
  State<SearchedScreen> createState() => _SearchedScreenState();
}

class _SearchedScreenState extends State<SearchedScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context)
        .findProductByName(productname: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results for " + widget.product),
        centerTitle: true,
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          print(state);
          if (state is SearchInitial) {
            BlocProvider.of<SearchCubit>(context)
                .findProductByName(productname: widget.product);

            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchLoaded) {
            return productView(context, state.results);
          } else if (state is SearchError) {
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
