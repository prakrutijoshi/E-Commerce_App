import 'dart:io';

abstract class FirebaseStorageRepository {
  Future<String> uploadImageFile(File file);
}
