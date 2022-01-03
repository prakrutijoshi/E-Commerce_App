import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageRemoteDatasource {
  Future<String> uploadImageFile({required File file, required String ref});
}

class FirebaseStorageRemoteDatasourceImpl
    implements FirebaseStorageRemoteDatasource {
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<String> uploadImageFile(
      {required File file, required String ref}) async {
    var storageRef = storage.ref().child(ref);
    var uploadTask = await storageRef.putFile(file);

    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }
}
