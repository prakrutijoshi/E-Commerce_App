import 'dart:io';

import 'package:bloc/bloc.dart';
import '../../../../domain/usecases/product_usecase/get_available_product_by_seller_id_usecase.dart';
import '../../../../domain/usecases/product_usecase/get_unAvailable_product_by_seller_id_usecase.dart';
import '../../../../data/models/product_model.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_seller_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/product_usecase/add_product_data_usecase.dart';
import '../../../../domain/usecases/product_usecase/update_product_data_usecase.dart';
import '../../../../domain/usecases/storage_usecase/upload_image_file_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final UploadImageFileUseCase uploadImageFileUseCase;
  final AddProductDataUseCase addProductDataUseCase;
  final UpdateProductDataUseCase updateProductDataUseCase;
  final LoggedFirebaseSellerUseCase loggedFirebaseSellerUseCase;
  final GetAvailableProductBySellerIdUseCase
      getAvailableProductBySellerIdUseCase;
  final GetUnAvailableProductBySellerIdUseCase
      getUnAvailableProductBySellerIdUseCase;

  ProductCubit({
    required this.uploadImageFileUseCase,
    required this.addProductDataUseCase,
    required this.updateProductDataUseCase,
    required this.loggedFirebaseSellerUseCase,
    required this.getAvailableProductBySellerIdUseCase,
    required this.getUnAvailableProductBySellerIdUseCase,
  }) : super(ProductInitial());

  Future<User> getSeller() async {
    return await loggedFirebaseSellerUseCase.call();
  }

  Future<List<String>> uploadImages({required List<XFile> images}) async {
    emit(ImagesUploading());
    try {
      var imageURLs = await Future.wait(
          images.map((image) => uploadImageFileUseCase.call(File(image.path))));
      emit(ImagesUploaded());
      return imageURLs;
    } catch (e) {
      emit(ImagesUploadError(message: "Image Upload Failed"));
      return [];
    }
  }

  Future<void> addProduct({required ProductModel newProduct}) async {
    emit(ProductUploading());
    try {
      await addProductDataUseCase.call(newProduct);
      emit(ProductUploaded());
    } catch (e) {
      emit(ProductError(message: "Product Upload Failed"));
    }
  }

  Future<void> getAvailableProductsBySeller() async {
    emit(ProductsLoading());
    try {
      User loggedUser = await loggedFirebaseSellerUseCase.call();
      String sid = loggedUser.uid;
      var products =
          await getAvailableProductBySellerIdUseCase.call(sellerId: sid);
      emit(ProductsLoaded(products: products as List<ProductModel>));
    } catch (e) {
      emit(ProductError(message: 'Failed to Load Products'));
    }
  }
}
