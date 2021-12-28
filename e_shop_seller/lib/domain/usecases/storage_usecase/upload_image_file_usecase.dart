import 'dart:io';

import '../../repositories/firebase_storage_repository.dart';

class UploadImageFileUseCase {
  FirebaseStorageRepository repository;

  UploadImageFileUseCase({required this.repository});

  Future<String> call(File file) async {
    return await repository.uploadImageFile(file);
  }
}
