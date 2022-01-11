import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/models/product_model.dart';
import '../../../../../domain/usecases/product_usecase/update_product_data_usecase.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  final UpdateProductDataUseCase updateProductDataUseCase;

  UpdateProductCubit({
    required this.updateProductDataUseCase,
  }) : super(UpdateProductInitial());

  Future<void> updateProduct({required ProductModel updatedProduct}) async {
    emit(ProductUpdating());
    try {
      await updateProductDataUseCase.call(updatedProduct);

      emit(UpdateProductDone());
    } catch (e) {
      emit(UpdateProductError(message: "Error while Updating Product"));
    }
  }
}
