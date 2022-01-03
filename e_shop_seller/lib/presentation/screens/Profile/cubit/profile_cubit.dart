import 'package:bloc/bloc.dart';
import 'package:e_shop_seller/data/models/seller_model.dart';
import 'package:e_shop_seller/domain/usecases/auth_usecases/logged_firebase_seller_usecase.dart';
import 'package:e_shop_seller/domain/usecases/seller_usecase/add_seller_data_usecase.dart';
import 'package:e_shop_seller/domain/usecases/seller_usecase/get_seller_by_id_usecase.dart';
import 'package:e_shop_seller/domain/usecases/seller_usecase/update_seller_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetSellerByIdUseCase getSellerByIdUseCase;
  final AddSellerDataUseCase addSellerDataUseCase;
  final UpdateSellerDataUseCase updateSellerDataUseCase;
  final LoggedFirebaseSellerUseCase loggedFirebaseSellerUseCase;

  ProfileCubit({
    required this.getSellerByIdUseCase,
    required this.addSellerDataUseCase,
    required this.updateSellerDataUseCase,
    required this.loggedFirebaseSellerUseCase,
  }) : super(ProfileInitial());

  Future<void> getSeller() async {
    emit(ProfileLoading());
    try {
      User loggedUser = await loggedFirebaseSellerUseCase.call();
      String uid = loggedUser.uid;
      var sellerInfo = await getSellerByIdUseCase.call(uid);
      emit(ProfileLoaded(sellerInfo as SellerModel));
    } catch (e) {
      emit(ProfileError("Failed to load Profile"));
    }
  }
}
