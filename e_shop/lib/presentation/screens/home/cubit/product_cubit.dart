import 'package:e_shop/data/model/product_model.dart';
import 'package:e_shop/domain/usecases/product_usecases/addtocart_usecase.dart';
import 'package:e_shop/domain/usecases/product_usecases/fetch_product_usecase.dart';
import 'package:e_shop/domain/usecases/product_usecases/find_product_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductUsecase fetchProductUsecase;
  final AddToCartUsecase addToCartUsecase;
  final FindProductUsecase findProductUsecase;

  ProductCubit(
      {required this.addToCartUsecase,
      required this.findProductUsecase,
      required this.fetchProductUsecase})
      : super(ProductInitial());

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
