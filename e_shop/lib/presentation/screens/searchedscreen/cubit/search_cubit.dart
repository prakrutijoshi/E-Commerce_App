import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/product_model.dart';
import '../../../../domain/usecases/product_usecases/fetch_product_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FetchProductUsecase fetchProductUsecase;
  var page = 1;
  var oldProducts = [];
  var isLoading = false;

  SearchCubit({
    required this.fetchProductUsecase,
  }) : super(SearchInitial());

  Future<void> findProductByName({required String productname}) async {
    try {
      isLoading = true;
      var products = await fetchProductUsecase.call(page);
      oldProducts = products;
      var results = oldProducts
          .where(
              (p) => p.name.toLowerCase().contains(productname.toLowerCase()))
          .toList();

      emit(SearchLoaded(results as List<ProductModel>, isLoading));
      page++;
      isLoading = false;
    } catch (e) {
      emit(SearchError(message: 'Failed to find Products'));
    }
  }
}
