import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/auth_usecases/auth_exception_usecase.dart';
import '../../../../domain/usecases/auth_usecases/is_logged_in_usecase.dart';
import '../../../../domain/usecases/auth_usecases/sign_up_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SignUpUseCase signUpUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final AuthExceptionUseCase authExceptionUseCase;

  RegisterCubit({
    required this.signUpUseCase,
    required this.isLoggedInUseCase,
    required this.authExceptionUseCase,
  }) : super(RegisterInitial());

  Future<void> registerNewUser(
    UserEntity newUser,
    String password,
  ) async {
    emit(RegisterLoading());

    try {
      await signUpUseCase.call(newUser, password);

      bool isLoggedIn = await isLoggedInUseCase.call();

      if (isLoggedIn) {
        emit(RegisterSuccess());
      } else {
        final message = authExceptionUseCase.call();
        emit(RegisterFailure(message: message));
      }
    } catch (e) {
      emit(RegisterFailure(message: "Failed to Register"));
    }
  }
}
