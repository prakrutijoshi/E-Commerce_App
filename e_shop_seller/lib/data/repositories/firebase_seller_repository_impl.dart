import '../../domain/entities/seller_entity.dart';
import '../../domain/repositories/firebase_seller_repository.dart';
import '../datasources/remote_datasource/firebase_seller_remote_datasource.dart';
import '../models/seller_model.dart';

class FirebaseSellerRepositoryImpl implements FirebaseSellerRepository {
  FirebaseSellerRemoteDatasource remoteDataSource;

  FirebaseSellerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addSellerData(SellerEntity newSeller) async {
    return await remoteDataSource.addSellerData(newSeller as SellerModel);
  }

  @override
  Future<SellerEntity> getSellerById(String sid) async {
    return await remoteDataSource.getSellerById(sid);
  }

  @override
  Future<bool> isExistInCollection(String sid) async {
    return await remoteDataSource.isExistInCollection(sid);
  }

  @override
  Future<void> updateSellerData(SellerEntity updatedSeller) async {
    return await remoteDataSource
        .updateSellerData(updatedSeller as SellerModel);
  }
}
