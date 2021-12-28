import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

abstract class FirebaseStorageRemoteDatasource {
  Future<String> uploadImageFile(File file);
}

class FirebaseStorageRemoteDatasourceImpl
    implements FirebaseStorageRemoteDatasource {
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<String> uploadImageFile(File file) async {
    var productImageId = UniqueKey().toString() +
        DateTime.now().millisecondsSinceEpoch.toString();

    var storageRef = storage.ref().child("product_images/$productImageId");
    var uploadTask = await storageRef.putFile(file);

    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }
}
