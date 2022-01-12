import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/product_model.dart';
import '../../../../domain/usecases/product_usecases/fetch_product_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductUsecase fetchProductUsecase;
  var page = 1;
  var isLoading = false;
  var oldProducts = [];

  ProductCubit({required this.fetchProductUsecase}) : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      var productDetails = await fetchProductUsecase.call(page);
      oldProducts = productDetails;
      emit(ProductLoaded(oldProducts as List<ProductModel>, isLoading));
      page++;
      isLoading = false;
    } catch (e) {
      emit(ProductError(message: 'Failed to Load Products'));
    }
  }
}
