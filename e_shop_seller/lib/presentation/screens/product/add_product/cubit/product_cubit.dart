import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../../data/models/product_model.dart';
import '../../../../../domain/usecases/auth_usecases/logged_firebase_seller_usecase.dart';
import '../../../../../domain/usecases/product_usecase/add_product_data_usecase.dart';
import '../../../../../domain/usecases/product_usecase/update_product_data_usecase.dart';
import '../../../../../domain/usecases/storage_usecase/upload_image_file_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final UploadImageFileUseCase uploadImageFileUseCase;
  final AddProductDataUseCase addProductDataUseCase;
  final UpdateProductDataUseCase updateProductDataUseCase;
  final LoggedFirebaseSellerUseCase loggedFirebaseSellerUseCase;

  ProductCubit({
    required this.uploadImageFileUseCase,
    required this.addProductDataUseCase,
    required this.updateProductDataUseCase,
    required this.loggedFirebaseSellerUseCase,
  }) : super(ProductInitial());

  Future<User> getSeller() async {
    return await loggedFirebaseSellerUseCase.call();
  }

  Future<List<String>> uploadImages({required List<XFile> images}) async {
    emit(ImagesUploading());
    try {
      var uuid = Uuid();

      var productImageFolderId = UniqueKey().toString() +
          DateTime.now().millisecondsSinceEpoch.toString();

      var imageURLs = await Future.wait(
          images.map((image) async => await uploadImageFileUseCase.call(
                file: File(image.path),
                ref: "product_images/$productImageFolderId/${uuid.v1()}",
              )));
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
}
