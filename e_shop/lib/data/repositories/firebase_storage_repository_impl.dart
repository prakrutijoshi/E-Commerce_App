import 'dart:io';

import '../../domain/repositories/firebase_storage_repository.dart';
import '../datasource/remote_datasource/firebase_storage_remote_datasource.dart';

class FirebaseStorageRepositoryImpl implements FirebaseStorageRepository {
  FirebaseStorageRemoteDatasource remoteDataSource;

  FirebaseStorageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> uploadImageFile(
      {required File file, required String ref}) async {
    return await remoteDataSource.uploadImageFile(file: file, ref: ref);
  }
}
