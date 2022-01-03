import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/product_model.dart';
import '../../../../domain/usecases/product_usecases/fetch_product_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductUsecase fetchProductUsecase;

  ProductCubit({required this.fetchProductUsecase}) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());

    try {
      var productDetails = await fetchProductUsecase.call();
      emit(ProductLoaded(productDetails as List<ProductModel>));
    } catch (e) {
      emit(ProductError(message: 'Failed to Load Products'));
    }
  }
}
