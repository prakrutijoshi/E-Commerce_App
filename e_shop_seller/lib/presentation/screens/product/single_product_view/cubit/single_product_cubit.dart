import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/usecases/product_usecase/remove_product_usecase.dart';

part 'single_product_state.dart';

class SingleProductCubit extends Cubit<SingleProductState> {
  final RemoveProductUseCase removeProductUseCase;

  SingleProductCubit({
    required this.removeProductUseCase,
  }) : super(SingleProductInitial());

  Future<void> deleteSingleProduct(String productId) async {
    emit(SingleProductDeleting());
    try {
      await removeProductUseCase.call(productId);

      emit(SingleProductDeleted());
    } catch (e) {
      emit(SingleProductError(message: "Failed to Delete the Product"));
    }
  }
}
