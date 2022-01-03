import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/model/user_model.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import '../../../../domain/usecases/storage_usecases/upload_image_file_usecase.dart';
import '../../../../domain/usecases/user_usecases/get_user_by_id_usecase.dart';
import '../../../../domain/usecases/user_usecases/update_user_data_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserByIdUseCase getUserByIdUseCase;
  final UpdateUserDataUseCase updateUserDataUseCase;
  final LoggedFirebaseUserUseCase loggedFirebaseUserUseCase;
  final UploadImageFileUseCase uploadImageFileUseCase;

  ProfileCubit({
    required this.getUserByIdUseCase,
    required this.updateUserDataUseCase,
    required this.loggedFirebaseUserUseCase,
    required this.uploadImageFileUseCase,
  }) : super(ProfileInitial());

  Future<void> getUser() async {
    emit(ProfileLoading());
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;
      var userInfo = await getUserByIdUseCase.call(uid);
      //var user = UserInfo as UserModel;
      emit(ProfileLoaded(userInfo as UserModel));
    } catch (e) {
      emit(ProfileError("Failed to load Profile"));
    }
  }

  Future<String> uploadUserAvatar({required XFile imageFile}) async {
    emit(ProfileImageUploading());
    try {
      var profileImageId = UniqueKey().toString() +
          DateTime.now().millisecondsSinceEpoch.toString();

      var profileImageURL = await uploadImageFileUseCase.call(
        file: File(imageFile.path),
        ref: "users/profile_image/$profileImageId",
      );

      emit(ProfileImageUploaded());
      return profileImageURL;
    } catch (e) {
      emit(ProfileImageUploadError());
      return '';
    }
  }

  Future<void> updateUser(UserModel updatedUser) async {
    emit(ProfileUpdating());
    try {
      await updateUserDataUseCase.call(updatedUser);
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileUpdateError());
    }
  }
}
