import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/product_model.dart';
import '../../../../domain/usecases/product_usecases/fetch_product_usecase.dart';
import '../../../../domain/usecases/product_usecases/find_product_by_category_usecase.dart';
import '../../../../domain/usecases/product_usecases/find_product_by_id_usecase.dart';
import '../../../../domain/usecases/product_usecases/find_product_by_name_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FindProductByIdUsecase findProductByIdUsecase;
  final FindProductByCategoryUsecase findProductByCategoryUsecase;
  final FindProductByNameUsecase findProductByNameUsecase;
  final FetchProductUsecase fetchProductUsecase;

  SearchCubit({
    required this.fetchProductUsecase,
    required this.findProductByNameUsecase,
    required this.findProductByCategoryUsecase,
    required this.findProductByIdUsecase,
  }) : super(SearchInitial());

  Future<void> findProductByName({required String productname}) async {
    emit(SearchLoading());

    try {
      var products = await fetchProductUsecase.call();
      var results = products
          .where(
              (p) => p.name.toLowerCase().contains(productname.toLowerCase()))
          .toList();

      emit(SearchLoaded(results as List<ProductModel>));
    } catch (e) {
      emit(SearchError(message: 'Failed to find Products'));
    }
  }
}
