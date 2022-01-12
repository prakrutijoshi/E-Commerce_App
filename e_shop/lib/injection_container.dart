import 'package:e_shop/domain/usecases/product_usecases/get_all_products_usecase.dart';
import 'package:get_it/get_it.dart';

import 'data/datasource/remote_datasource/firebase_auth_remote_datasource.dart';
import 'data/datasource/remote_datasource/firebase_cart_remote_datasource.dart';
import 'data/datasource/remote_datasource/firebase_order_remote_datasource.dart';
import 'data/datasource/remote_datasource/firebase_storage_remote_datasource.dart';
import 'data/datasource/remote_datasource/firebase_user_remote_datasource.dart';
import 'data/datasource/remote_datasource/firebase_wishlist_remote%20datasource.dart';
import 'data/datasource/remote_datasource/productdatasource.dart';
import 'data/repositories/firbase_cart_repository_impl.dart';
import 'data/repositories/firebase_auth_repository_impl.dart';
import 'data/repositories/firebase_order_repository_impl.dart';
import 'data/repositories/firebase_storage_repository_impl.dart';
import 'data/repositories/firebase_user_repository_impl.dart';
import 'data/repositories/firebase_wishlist_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/firebase_auth_repository.dart';
import 'domain/repositories/firebase_cart_repository.dart';
import 'domain/repositories/firebase_order_repository.dart';
import 'domain/repositories/firebase_storage_repository.dart';
import 'domain/repositories/firebase_user_repository.dart';
import 'domain/repositories/firebase_wishlist_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/auth_usecases/auth_exception_usecase.dart';
import 'domain/usecases/auth_usecases/is_logged_in_usecase.dart';
import 'domain/usecases/auth_usecases/log_in_with_email_and_password_usecase.dart';
import 'domain/usecases/auth_usecases/log_in_with_google_usecase.dart';
import 'domain/usecases/auth_usecases/log_out_from_google_usecase.dart';
import 'domain/usecases/auth_usecases/log_out_usecase.dart';
import 'domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import 'domain/usecases/auth_usecases/send_password_reset_email_usecase.dart';
import 'domain/usecases/auth_usecases/sign_up_usecase.dart';
import 'domain/usecases/cart_usecases/add_cart_item_usecase.dart';
import 'domain/usecases/cart_usecases/clear_cart_usecase.dart';
import 'domain/usecases/cart_usecases/fetch_cart_usecase.dart';
import 'domain/usecases/cart_usecases/remove_cart_item_usecase.dart';
import 'domain/usecases/cart_usecases/update_cart_item_usecase.dart';
import 'domain/usecases/order_usecases/add_order_usecase.dart';
import 'domain/usecases/order_usecases/get_orders_usecase.dart';
import 'domain/usecases/order_usecases/remove_order_usecase.dart';
import 'domain/usecases/product_usecases/fetch_product_usecase.dart';
import 'domain/usecases/product_usecases/find_product_by_category_usecase.dart';
import 'domain/usecases/product_usecases/find_product_by_id_usecase.dart';
import 'domain/usecases/storage_usecases/upload_image_file_usecase.dart';
import 'domain/usecases/user_usecases/add_user_data_usecase.dart';
import 'domain/usecases/user_usecases/get_user_by_id_usecase.dart';
import 'domain/usecases/user_usecases/update_user_data_usecase.dart';
import 'domain/usecases/wishlist_usecases/add_wishlist_item_usecase.dart';
import 'domain/usecases/wishlist_usecases/clear_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/fetch_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/is_exists_in_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/remove_wishlist_item_usecase.dart';
import 'presentation/common_cubits/cubit/cubit/authentication_cubit.dart';
import 'presentation/screens/Cart/cubit/cart_cubit.dart';
import 'presentation/screens/WishList/cubit/wishlist_cubit.dart';
import 'presentation/screens/categoryscreen/cubit/category_cubit.dart';
import 'presentation/screens/home/cubit/product_cubit.dart';
import 'presentation/screens/login/cubit/login_cubit.dart';
import 'presentation/screens/my_orders/cubit/my_order_cubit.dart';
import 'presentation/screens/profile/cubit/profile_cubit.dart';
import 'presentation/screens/register/cubit/register_cubit.dart';
import 'presentation/screens/searchedscreen/cubit/search_cubit.dart';
import 'presentation/screens/shipping_address/cubit/address_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubit
  sl.registerFactory<AuthenticationCubit>(
    () => AuthenticationCubit(
        isLoggedInUseCase: sl.call(),
        logOutUseCase: sl.call(),
        logOutFromGoogleUseCase: sl.call(),
        loggedFirebaseUserUseCase: sl.call(),
        sendPasswordResetEmailUseCase: sl.call()),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      logInWithEmailAndPasswordUseCase: sl.call(),
      isLoggedInUseCase: sl.call(),
      authExceptionUseCase: sl.call(),
      logInWithGoogleUseCase: sl.call(),
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
      getAllProductsUseCase: sl.call(),
    ),
  );
  sl.registerFactory<CategoryCubit>(
    () => CategoryCubit(
      findProductByCategoryUsecase: sl.call(),
      fetchProductUsecase: sl.call(),
    ),
  );

  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getUserByIdUseCase: sl.call(),
      updateUserDataUseCase: sl.call(),
      loggedFirebaseUserUseCase: sl.call(),
      uploadImageFileUseCase: sl.call(),
    ),
  );
  sl.registerFactory<CartCubit>(
    () => CartCubit(
      loggedFirebaseUserUseCase: sl.call(),
      fetchCartUseCase: sl.call(),
      addCartItemUseCase: sl.call(),
      removeCartItemUseCase: sl.call(),
      updateCartItemUseCase: sl.call(),
      clearCartUseCase: sl.call(),
      findProductByIdUsecase: sl.call(),
    ),
  );
  sl.registerFactory<MyOrderCubit>(() => MyOrderCubit(
        getOrdersUseCase: sl.call(),
        addOrderUseCase: sl.call(),
        removeOrderUseCase: sl.call(),
        loggedFirebaseUserUseCase: sl.call(),
      ));

  sl.registerFactory<WishlistCubit>(
    () => WishlistCubit(
      loggedFirebaseUserUseCase: sl.call(),
      fetchWishListUseCase: sl.call(),
      addWishListItemUseCase: sl.call(),
      removeWishListItemUseCase: sl.call(),
      isExistsInWishListUseCase: sl.call(),
      clearWishListUseCase: sl.call(),
      findProductByIdUsecase: sl.call(),
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
  sl.registerLazySingleton<LogInWithGoogleUseCase>(
      () => LogInWithGoogleUseCase(sl.call()));
  sl.registerLazySingleton<LogOutFromGoogleUseCase>(
      () => LogOutFromGoogleUseCase(sl.call()));

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
  sl.registerLazySingleton<GetAllProductsUseCase>(
      () => GetAllProductsUseCase(sl.call()));

  // Storage Usecases
  sl.registerLazySingleton<UploadImageFileUseCase>(
      () => UploadImageFileUseCase(repository: sl.call()));

  // Cart Usecases
  sl.registerLazySingleton<AddCartItemUseCase>(
      () => AddCartItemUseCase(repository: sl.call()));
  sl.registerLazySingleton<ClearCartUseCase>(
      () => ClearCartUseCase(repository: sl.call()));
  sl.registerLazySingleton<FetchCartUseCase>(
      () => FetchCartUseCase(repository: sl.call()));
  sl.registerLazySingleton<RemoveCartItemUseCase>(
      () => RemoveCartItemUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateCartItemUseCase>(
      () => UpdateCartItemUseCase(repository: sl.call()));

  // WishList Usecases
  sl.registerLazySingleton<AddWishListItemUseCase>(
      () => AddWishListItemUseCase(repository: sl.call()));
  sl.registerLazySingleton<FetchWishListUseCase>(
      () => FetchWishListUseCase(repository: sl.call()));
  sl.registerLazySingleton<RemoveWishListItemUseCase>(
      () => RemoveWishListItemUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsExistsInWishListUseCase>(
      () => IsExistsInWishListUseCase(repository: sl.call()));
  sl.registerLazySingleton<ClearWishListUseCase>(
      () => ClearWishListUseCase(repository: sl.call()));
  // Order Usecase
  sl.registerLazySingleton<AddOrderUseCase>(
      () => AddOrderUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetOrdersUseCase>(
      () => GetOrdersUseCase(repository: sl.call()));
  sl.registerLazySingleton<RemoveOrderUseCase>(
      () => RemoveOrderUseCase(repository: sl.call()));

  // repository
  sl.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(sl.call()));
  sl.registerLazySingleton<FirebaseUserRepository>(
      () => FirebaseUserRepositoryImpl(sl.call()));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl.call()));
  sl.registerLazySingleton<FirebaseStorageRepository>(
      () => FirebaseStorageRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<FirebaseCartRepository>(
      () => FirebaseCartRepositoryImpl(remoteDatasource: sl.call()));
  sl.registerLazySingleton<FirebaseWishListRepository>(
      () => FirebaseWishListRepositoryImpl(remoteDatasource: sl.call()));
  sl.registerLazySingleton<FirebaseOrderRepository>(
      () => FirebaseOrderRepositoryImpl(remoteDatasource: sl.call()));

  // datasource
  sl.registerLazySingleton<FirebaseAuthRemoteDatasource>(
      () => FirebaseAuthRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseUserRemoteDatasource>(
      () => FirebaseUserRemoteDatasourceImpl());
  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSourceImpl());
  sl.registerLazySingleton<FirebaseStorageRemoteDatasource>(
      () => FirebaseStorageRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseCartRemoteDatasource>(
      () => FirebaseCartRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseWishlistRemoteDatasource>(
      () => FirebaseWishListRemoteDatasourceImpl());
  sl.registerLazySingleton<FirebaseOrderRemoteDatasource>(
      () => FirebaseOrderRemoteDatasourceImpl());
}
