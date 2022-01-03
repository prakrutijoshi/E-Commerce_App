import 'package:e_shop/data/model/product_model.dart';
import 'package:e_shop/domain/usecases/product_usecases/find_product_by_category_usecase.dart';
import 'package:e_shop/domain/usecases/product_usecases/find_product_by_id_usecase.dart';
import 'package:e_shop/domain/usecases/product_usecases/find_product_by_name_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FindProductByIdUsecase findProductByIdUsecase;
  final FindProductByCategoryUsecase findProductByCategoryUsecase;
  final FindProductByNameUsecase findProductByNameUsecase;

  SearchCubit({
    required this.findProductByNameUsecase,
    required this.findProductByCategoryUsecase,
    required this.findProductByIdUsecase,
  }) : super(SearchInitial());

  Future<void> findProductByName({required String productname}) async {
    emit(SearchLoading());

    try {
      var products = await findProductByNameUsecase.call(productname);
      emit(SearchLoaded(products as List<ProductModel>));
    } catch (e) {
      emit(SearchError(message: 'Failed to find Products'));
    }
  }
}
