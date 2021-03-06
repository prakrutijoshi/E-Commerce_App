import 'package:get_it/get_it.dart';

import 'data/datasources/remote_datasource/firebase_auth_remote_datasource.dart';
import 'data/datasources/remote_datasource/firebase_order_remote_datasource.dart';
import 'data/datasources/remote_datasource/firebase_product_remote_datasource.dart';
import 'data/datasources/remote_datasource/firebase_seller_remote_datasource.dart';
import 'data/datasources/remote_datasource/firebase_storage_remote_datasource.dart';
import 'data/repositories/firbase_storage_repository_impl.dart';
import 'data/repositories/firebase_auth_repository_impl.dart';
import 'data/repositories/firebase_order_repository_impl.dart';
import 'data/repositories/firebase_product_repository_impl.dart';
import 'data/repositories/firebase_seller_repository_impl.dart';
import 'domain/repositories/firebase_auth_repository.dart';
import 'domain/repositories/firebase_order_repository.dart';
import 'domain/repositories/firebase_product_repository.dart';
import 'domain/repositories/firebase_seller_repository.dart';
import 'domain/repositories/firebase_storage_repository.dart';
import 'domain/usecases/auth_usecases/auth_exception_usecase.dart';
import 'domain/usecases/auth_usecases/is_logged_in_usecase.dart';
import 'domain/usecases/auth_usecases/log_in_with_email_and_password.dart';
import 'domain/usecases/auth_usecases/log_in_with_google_usecase.dart';
import 'domain/usecases/auth_usecases/log_out_from_google.dart';
import 'domain/usecases/auth_usecases/log_out_usecase.dart';
import 'domain/usecases/auth_usecases/logged_firebase_seller_usecase.dart';
import 'domain/usecases/auth_usecases/send_password_reset_email_usecase.dart';
import 'domain/usecases/auth_usecases/sign_up_usecase.dart';
import 'domain/usecases/order_usecases/get_orders_usecase.dart';
import 'domain/usecases/product_usecase/add_product_data_usecase.dart';
import 'domain/usecases/product_usecase/get_available_product_by_seller_id_usecase.dart';
import 'domain/usecases/product_usecase/get_product_by_id_usecase.dart';
import 'domain/usecases/product_usecase/get_unAvailable_product_by_seller_id_usecase.dart';
import 'domain/usecases/product_usecase/remove_product_usecase.dart';
import 'domain/usecases/product_usecase/update_product_data_usecase.dart';
import 'domain/usecases/seller_usecase/add_seller_data_usecase.dart';
import 'domain/usecases/seller_usecase/get_seller_by_id_usecase.dart';
import 'domain/usecases/seller_usecase/is_exist_in_collection_usecase.dart';
import 'domain/usecases/seller_usecase/update_seller_data_usecase.dart';
import 'domain/usecases/storage_usecase/upload_image_file_usecase.dart';
import 'presentation/common_cubits/authentication/authentication_cubit.dart';
import 'presentation/screens/Profile/cubit/profile_cubit.dart';
import 'presentation/screens/login/cubit/login_cubit.dart';
import 'presentation/screens/orders/cubit/order_cubit.dart';
import 'presentation/screens/product/add_product/cubit/product_cubit.dart';
import 'presentation/screens/product/display_products/in_stock_products/cubit/instockproducts_cubit.dart';
import 'presentation/screens/product/display_products/out_of_stock_products/cubit/outofstockproducts_cubit.dart';
import 'presentation/screens/product/single_product_view/cubit/single_product_cubit.dart';
import 'presentation/screens/product/update_product/cubit/update_product_cubit.dart';
import 'presentation/screens/register/cubit/register_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubit
  sl.registerFactory<AuthenticationCubit>(
    () => AuthenticationCubit(
      isLoggedInUseCase: sl.call(),
      logOutUseCase: sl.call(),
      logOutFromGoogleUseCase: sl.call(),
      loggedFirebaseSellerUseCase: sl.call(),
      sendPasswordResetEmailUseCase: sl.call(),
    ),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
        logInWithEmailAndPasswordUseCase: sl.call(),
        isLoggedInUseCase: sl.call(),
        authExceptionUseCase: sl.call(),
        logInWithGoogleUseCase: sl.call()),
  );
  sl.registerFactory<RegisterCubit>(
    () => RegisterCubit(
      signUpUseCase: sl.call(),
      isLoggedInUseCase: sl.call(),
      authExceptionUseCase: sl.call(),
    ),
  );
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(
      uploadImageFileUseCase: sl.call(),
      addProductDataUseCase: sl.call(),
      updateProductDataUseCase: sl.call(),
      loggedFirebaseSellerUseCase: sl.call(),
    ),
  );
  sl.registerFactory<InstockproductsCubit>(
    () => InstockproductsCubit(
      getAvailableProductBySellerIdUseCase: sl.call(),
      loggedFirebaseSellerUseCase: sl.call(),
    ),
  );
  sl.registerFactory<OutofstockproductsCubit>(
    () => OutofstockproductsCubit(
      getUnAvailableProductBySellerIdUseCase: sl.call(),
      loggedFirebaseSellerUseCase: sl.call(),
    ),
  );
  sl.registerFactory<UpdateProductCubit>(
    () => UpdateProductCubit(
      updateProductDataUseCase: sl.call(),
    ),
  );
  sl.registerFactory<SingleProductCubit>(
    () => SingleProductCubit(
      removeProductUseCase: sl.call(),
    ),
  );

  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getSellerByIdUseCase: sl.call(),
      updateSellerDataUseCase: sl.call(),
      loggedFirebaseSellerUseCase: sl.call(),
      uploadImageFileUseCase: sl.call(),
    ),
  );
  sl.registerFactory<OrderCubit>(
    () => OrderCubit(
      getOrdersUseCase: sl.call(),
      loggedFirebaseSellerUseCase: sl.call(),
    ),
  );

  // auth usecase
  sl.registerLazySingleton<IsLoggedInUseCase>(
      () => IsLoggedInUseCase(sl.call()));
  sl.registerLazySingleton<LogInWithEmailAndPasswordUseCase>(
      () => LogInWithEmailAndPasswordUseCase(sl.call()));
  sl.registerLazySingleton<LogOutUseCase>(() => LogOutUseCase(sl.call()));
  sl.registerLazySingleton<LoggedFirebaseSellerUseCase>(
      () => LoggedFirebaseSellerUseCase(sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl.call()));
  sl.registerLazySingleton<AuthExceptionUseCase>(
      () => AuthExceptionUseCase(sl.call()));
  sl.registerLazySingleton<SendPasswordResetEmailUseCase>(
      () => SendPasswordResetEmailUseCase(repository: sl.call()));
  sl.registerLazySingleton<LogInWithGoogleUseCase>(
      () => LogInWithGoogleUseCase(sl.call()));
  sl.registerLazySingleton<LogOutFromGoogleUseCase>(
      () => LogOutFromGoogleUseCase(sl.call()));

  // seller usecase
  sl.registerLazySingleton<AddSellerDataUseCase>(
      () => AddSellerDataUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetSellerByIdUseCase>(
      () => GetSellerByIdUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsExistInCollectionUseCase>(
      () => IsExistInCollectionUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateSellerDataUseCase>(
      () => UpdateSellerDataUseCase(repository: sl.call()));

  // product usecase
  sl.registerLazySingleton<AddProductDataUseCase>(
      () => AddProductDataUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetProductByIdUseCase>(
      () => GetProductByIdUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAvailableProductBySellerIdUseCase>(
      () => GetAvailableProductBySellerIdUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUnAvailableProductBySellerIdUseCase>(
      () => GetUnAvailableProductBySellerIdUseCase(repository: sl.call()));
  sl.registerLazySingleton<RemoveProductUseCase>(
      () => RemoveProductUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateProductDataUseCase>(
      () => UpdateProductDataUseCase(repository: sl.call()));

  // storage usecase
  sl.registerLazySingleton<UploadImageFileUseCase>(
      () => UploadImageFileUseCase(repository: sl.call()));

  // Order Usecase
  sl.registerLazySingleton<GetOrdersUseCase>(
      () => GetOrdersUseCase(repository: sl.call()));

  // repository
  sl.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(sl.call()));
  sl.registerLazySingleton<FirebaseSellerRepository>(
      () => FirebaseSellerRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<FirebaseProductRepository>(
      () => FirebaseProductRepositoryImpl(sl.call()));
  sl.registerLazySingleton<FirebaseStorageRepository>(
      () => FirebaseStorageRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<FirebaseOrderRepository>(
      () => FirebaseOrderRepositoryImpl(remoteDatasource: sl.call()));

  // datasource
  sl.registerLazySingleton<FirebaseAuthRemoteDatasource>(
      () => FirebaseAuthRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseSellerRemoteDatasource>(
      () => FirebaseSellerRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseProductRemoteDatasource>(
      () => FirebaseProductRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseStorageRemoteDatasource>(
      () => FirebaseStorageRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseOrderRemoteDatasource>(
      () => FirebaseOrderRemoteDatasourceImpl());
}
