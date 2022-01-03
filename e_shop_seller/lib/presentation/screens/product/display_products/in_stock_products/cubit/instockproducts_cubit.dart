import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../data/models/product_model.dart';
import '../../../../../../domain/entities/product_entity.dart';
import '../../../../../../domain/usecases/auth_usecases/logged_firebase_seller_usecase.dart';
import '../../../../../../domain/usecases/product_usecase/get_available_product_by_seller_id_usecase.dart';

part 'instockproducts_state.dart';

class InstockproductsCubit extends Cubit<InstockproductsState> {
  final GetAvailableProductBySellerIdUseCase
      getAvailableProductBySellerIdUseCase;
  final LoggedFirebaseSellerUseCase loggedFirebaseSellerUseCase;

  late StreamSubscription<List<ProductEntity>> getProductsSub;

  InstockproductsCubit({
    required this.getAvailableProductBySellerIdUseCase,
    required this.loggedFirebaseSellerUseCase,
  }) : super(InstockproductsInitial());

  Future<void> getAvailableProductsBySeller() async {
    emit(InstockproductsLoading());
    try {
      User loggedUser = await loggedFirebaseSellerUseCase.call();
      String sid = loggedUser.uid;
      var streamProducts =
          getAvailableProductBySellerIdUseCase.call(sellerId: sid);

      getProductsSub = streamProducts.listen((products) {
        emit(InstockproductsLoaded(products: products as List<ProductModel>));
      });
    } catch (e) {
      emit(InstockproductsError(message: 'Failed to Load Products'));
    }
  }

  @override
  Future<void> close() async {
    await getProductsSub.cancel();
    return super.close();
  }
}
