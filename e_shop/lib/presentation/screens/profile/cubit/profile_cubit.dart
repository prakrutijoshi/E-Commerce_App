import 'package:bloc/bloc.dart';
import 'package:e_shop/data/model/user_model.dart';
import 'package:e_shop/domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import 'package:e_shop/domain/usecases/user_usecases/add_user_data_usecase.dart';
import 'package:e_shop/domain/usecases/user_usecases/get_user_by_id_usecase.dart';
import 'package:e_shop/domain/usecases/user_usecases/update_user_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserByIdUseCase getUserByIdUseCase;
  final AddUserDataUseCase addUserDataUseCase;
  final UpdateUserDataUseCase updateUserDataUseCase;
  final LoggedFirebaseUserUseCase loggedFirebaseUserUseCase;

  ProfileCubit({
    required this.getUserByIdUseCase,
    required this.addUserDataUseCase,
    required this.updateUserDataUseCase,
    required this.loggedFirebaseUserUseCase,
  }) : super(ProfileInitial());

  Future<void> getUser() async {
    emit(ProfileLoading());
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;
      var userInfo = await getUserByIdUseCase.call(uid);
      //var user = UserInfo as UserModel;
      emit(ProfileLoaded(userInfo as UserModel));
    } catch (e) {
      emit(ProfileError("Failed to load Profile"));
    }
  }
}
