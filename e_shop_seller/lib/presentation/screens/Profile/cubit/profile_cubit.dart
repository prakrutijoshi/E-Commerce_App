import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/seller_model.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_seller_usecase.dart';
import '../../../../domain/usecases/seller_usecase/get_seller_by_id_usecase.dart';
import '../../../../domain/usecases/seller_usecase/update_seller_data_usecase.dart';
import '../../../../domain/usecases/storage_usecase/upload_image_file_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetSellerByIdUseCase getSellerByIdUseCase;
  final UpdateSellerDataUseCase updateSellerDataUseCase;
  final LoggedFirebaseSellerUseCase loggedFirebaseSellerUseCase;
  final UploadImageFileUseCase uploadImageFileUseCase;

  ProfileCubit({
    required this.getSellerByIdUseCase,
    required this.updateSellerDataUseCase,
    required this.loggedFirebaseSellerUseCase,
    required this.uploadImageFileUseCase,
  }) : super(ProfileInitial());

  Future<void> getSeller() async {
    emit(ProfileLoading());
    try {
      User loggedUser = await loggedFirebaseSellerUseCase.call();
      String uid = loggedUser.uid;
      var sellerInfo = await getSellerByIdUseCase.call(uid);
      emit(ProfileLoaded(sellerInfo as SellerModel));
    } catch (e) {
      emit(ProfileError("Failed to load Profile"));
    }
  }

  Future<String> uploadSellerAvatar({required XFile imageFile}) async {
    emit(ProfileImageUploading());
    try {
      var profileImageId = UniqueKey().toString() +
          DateTime.now().millisecondsSinceEpoch.toString();

      var profileImageURL = await uploadImageFileUseCase.call(
        file: File(imageFile.path),
        ref: "sellers/profile_image/$profileImageId",
      );

      emit(ProfileImageUploaded());
      print(profileImageURL);
      return profileImageURL;
    } catch (e) {
      emit(ProfileImageUploadError());
      return '';
    }
  }

  Future<void> updateSeller(SellerModel updatedSeller) async {
    emit(ProfileUpdating());
    try {
      await updateSellerDataUseCase.call(updatedSeller);
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileUpdateError());
    }
  }
}
