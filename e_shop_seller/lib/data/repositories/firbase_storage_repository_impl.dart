import 'dart:io';

import '../../domain/repositories/firebase_storage_repository.dart';
import '../datasources/remote_datasource/firebase_storage_remote_datasource.dart';

class FirebaseStorageRepositoryImpl implements FirebaseStorageRepository {
  FirebaseStorageRemoteDatasource remoteDataSource;

  FirebaseStorageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> uploadImageFile(File file) async {
    return await remoteDataSource.uploadImageFile(file);
  }
}
