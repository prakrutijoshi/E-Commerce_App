import 'package:e_shop/data/model/product_model.dart';
import 'package:e_shop/domain/usecases/product_usecases/fetch_product_usecase.dart';
import 'package:e_shop/domain/usecases/product_usecases/find_product_by_category_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FindProductByCategoryUsecase findProductByCategoryUsecase;
  final FetchProductUsecase fetchProductUsecase;

  CategoryCubit({
    required this.fetchProductUsecase,
    required this.findProductByCategoryUsecase,
  }) : super(CategoryInitial());

  Future<void> findProductByCategory({required String category}) async {
    emit(CategoryLoading());

    try {
      var products = await findProductByCategoryUsecase.call(category);

      emit(CategoryLoaded(products as List<ProductModel>));
    } catch (e) {
      emit(CategoryError(message: 'Failed to find Products'));
    }
  }
}
