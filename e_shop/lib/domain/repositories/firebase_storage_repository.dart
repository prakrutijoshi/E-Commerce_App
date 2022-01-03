import 'dart:io';

abstract class FirebaseStorageRepository {
  Future<String> uploadImageFile({required File file, required String ref});
}
