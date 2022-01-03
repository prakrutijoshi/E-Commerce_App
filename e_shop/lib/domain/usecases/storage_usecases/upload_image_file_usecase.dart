import 'dart:io';

import '../../repositories/firebase_storage_repository.dart';

class UploadImageFileUseCase {
  FirebaseStorageRepository repository;

  UploadImageFileUseCase({required this.repository});

  Future<String> call({required File file, required String ref}) async {
    return await repository.uploadImageFile(file: file, ref: ref);
  }
}
