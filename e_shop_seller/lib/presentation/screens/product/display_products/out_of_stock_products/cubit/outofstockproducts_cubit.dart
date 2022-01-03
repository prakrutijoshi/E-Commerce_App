import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../../../../domain/entities/product_entity.dart';
import '../../../../../../data/models/product_model.dart';
import '../../../../../../domain/usecases/auth_usecases/logged_firebase_seller_usecase.dart';
import '../../../../../../domain/usecases/product_usecase/get_unAvailable_product_by_seller_id_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'outofstockproducts_state.dart';

class OutofstockproductsCubit extends Cubit<OutofstockproductsState> {
  final GetUnAvailableProductBySellerIdUseCase
      getUnAvailableProductBySellerIdUseCase;
  final LoggedFirebaseSellerUseCase loggedFirebaseSellerUseCase;

  late StreamSubscription<List<ProductEntity>> getProductsSub;

  OutofstockproductsCubit({
    required this.getUnAvailableProductBySellerIdUseCase,
    required this.loggedFirebaseSellerUseCase,
  }) : super(OutofstockproductsInitial());

  Future<void> getUnAvailableProductsBySeller() async {
    emit(OutofstockproductsLoading());
    try {
      User loggedUser = await loggedFirebaseSellerUseCase.call();
      String sid = loggedUser.uid;

      var streamProducts =
          getUnAvailableProductBySellerIdUseCase.call(sellerId: sid);

      getProductsSub = streamProducts.listen((products) {
        emit(
            OutofstockproductsLoaded(products: products as List<ProductModel>));
      });
    } catch (e) {
      emit(OutofstockproductsError(message: 'Failed to Load Products'));
    }
  }

  @override
  Future<void> close() async {
    await getProductsSub.cancel();
    return super.close();
  }
}
