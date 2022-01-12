import 'package:e_shop/domain/usecases/product_usecases/get_all_products_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/product_model.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  SearchCubit({
    required this.getAllProductsUseCase,
  }) : super(SearchInitial());

  Future<void> findProductByName({required String productname}) async {
    try {
      var products = await getAllProductsUseCase.call();
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
