import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/product_model.dart';
import '../../../../domain/usecases/product_usecases/fetch_product_usecase.dart';
import '../../../../domain/usecases/product_usecases/find_product_by_category_usecase.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FindProductByCategoryUsecase findProductByCategoryUsecase;
  final FetchProductUsecase fetchProductUsecase;
  var page = 1;
  var isLoading = false;
  var oldProducts = [];

  CategoryCubit({
    required this.fetchProductUsecase,
    required this.findProductByCategoryUsecase,
  }) : super(CategoryInitial());

  Future<void> findProductByCategory({required String category}) async {
    if (page == 1) {
      emit(CategoryLoading());
      print('xyz');
    }
    try {
      isLoading = true;
      var products = await findProductByCategoryUsecase.call(category, page);
      oldProducts = products;
      emit(CategoryLoaded(oldProducts as List<ProductModel>, isLoading));
      page++;
      isLoading = false;
    } catch (e) {
      emit(CategoryError(message: 'Failed to find Products'));
    }
  }
}
