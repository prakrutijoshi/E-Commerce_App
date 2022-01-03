import 'package:e_shop/domain/usecases/product_usecases/find_product_by_category_usecase.dart';
import 'package:e_shop/domain/usecases/product_usecases/find_product_by_name_usecase.dart';
import 'package:e_shop/presentation/screens/searchedscreen/cubit/search_cubit.dart';

import 'data/datasource/remote_datasource/productdatasource.dart';
import 'data/repositories/firebase_user_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/firebase_user_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/auth_usecases/send_password_reset_email_usecase.dart';
import 'domain/usecases/product_usecases/fetch_product_usecase.dart';
import 'domain/usecases/user_usecases/add_user_data_usecase.dart';
import 'domain/usecases/user_usecases/get_user_by_id_usecase.dart';
import 'domain/usecases/user_usecases/update_user_data_usecase.dart';
import 'presentation/common_cubits/cubit/cubit/authentication_cubit.dart';
import 'presentation/screens/home/cubit/product_cubit.dart';
import 'presentation/screens/shipping_address/cubit/address_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/datasource/remote_datasource/firebase_auth_remote_datasource.dart';
import 'data/datasource/remote_datasource/firebase_user_remote_datasource.dart';
import 'data/repositories/firebase_auth_repository_impl.dart';
import 'domain/repositories/firebase_auth_repository.dart';
import 'domain/usecases/auth_usecases/auth_exception_usecase.dart';
import 'domain/usecases/auth_usecases/is_logged_in_usecase.dart';
import 'domain/usecases/auth_usecases/log_in_with_email_and_password_usecase.dart';
import 'domain/usecases/auth_usecases/log_out_usecase.dart';
import 'domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import 'domain/usecases/auth_usecases/sign_up_usecase.dart';
import 'domain/usecases/product_usecases/find_product_by_id_usecase.dart';
import 'presentation/screens/login/cubit/login_cubit.dart';
import 'presentation/screens/register/cubit/register_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubit
  sl.registerFactory<AuthenticationCubit>(
    () => AuthenticationCubit(
        isLoggedInUseCase: sl.call(),
        logOutUseCase: sl.call(),
        loggedFirebaseUserUseCase: sl.call(),
        sendPasswordResetEmailUseCase: sl.call()),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      logInWithEmailAndPasswordUseCase: sl.call(),
      isLoggedInUseCase: sl.call(),
      authExceptionUseCase: sl.call(),
    ),
  );
  sl.registerFactory<RegisterCubit>(
    () => RegisterCubit(
      signUpUseCase: sl.call(),
      isLoggedInUseCase: sl.call(),
      authExceptionUseCase: sl.call(),
    ),
  );
  sl.registerFactory<AddressCubit>(
    () => AddressCubit(
      getUserByIdUseCase: sl.call(),
      updateUserDataUseCase: sl.call(),
      addUserDataUseCase: sl.call(),
      loggedFirebaseUserUseCase: sl.call(),
    ),
  );
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(
      fetchProductUsecase: sl.call(),
    ),
  );
  sl.registerFactory<SearchCubit>(
    () => SearchCubit(
      findProductByIdUsecase: sl.call(),
      findProductByCategoryUsecase: sl.call(),
      findProductByNameUsecase: sl.call(),
    ),
  );
  // auth usecase
  sl.registerLazySingleton<IsLoggedInUseCase>(
      () => IsLoggedInUseCase(sl.call()));
  sl.registerLazySingleton<LogInWithEmailAndPasswordUseCase>(
      () => LogInWithEmailAndPasswordUseCase(sl.call()));
  sl.registerLazySingleton<LogOutUseCase>(() => LogOutUseCase(sl.call()));
  sl.registerLazySingleton<LoggedFirebaseUserUseCase>(
      () => LoggedFirebaseUserUseCase(sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl.call()));
  sl.registerLazySingleton<AuthExceptionUseCase>(
      () => AuthExceptionUseCase(sl.call()));
  sl.registerLazySingleton<SendPasswordResetEmailUseCase>(
      () => SendPasswordResetEmailUseCase(repository: sl.call()));

  // user usecase
  sl.registerLazySingleton<AddUserDataUseCase>(
      () => AddUserDataUseCase(sl.call()));
  sl.registerLazySingleton<GetUserByIdUseCase>(
      () => GetUserByIdUseCase(sl.call()));
  sl.registerLazySingleton<UpdateUserDataUseCase>(
      () => UpdateUserDataUseCase(sl.call()));

  // Product Usecases
  sl.registerLazySingleton<FetchProductUsecase>(
      () => FetchProductUsecase(sl.call()));
  sl.registerLazySingleton<FindProductByIdUsecase>(
      () => FindProductByIdUsecase(sl.call()));
  sl.registerLazySingleton<FindProductByCategoryUsecase>(
      () => FindProductByCategoryUsecase(sl.call()));
  sl.registerLazySingleton<FindProductByNameUsecase>(
      () => FindProductByNameUsecase(sl.call()));

  // repository
  sl.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(sl.call()));
  sl.registerLazySingleton<FirebaseUserRepository>(
      () => FirebaseUserRepositoryImpl(sl.call()));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl.call()));

  // datasource
  sl.registerLazySingleton<FirebaseAuthRemoteDatasource>(
      () => FirebaseAuthRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseUserRemoteDatasource>(
      () => FirebaseUserRemoteDatasourceImpl());
  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSourceImpl());
}
