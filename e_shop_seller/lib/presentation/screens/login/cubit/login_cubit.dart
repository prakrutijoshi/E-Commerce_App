import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/auth_usecases/auth_exception_usecase.dart';
import '../../../../domain/usecases/auth_usecases/is_logged_in_usecase.dart';
import '../../../../domain/usecases/auth_usecases/log_in_with_email_and_password.dart';
import '../../../../domain/usecases/auth_usecases/log_in_with_google_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LogInWithEmailAndPasswordUseCase logInWithEmailAndPasswordUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final AuthExceptionUseCase authExceptionUseCase;
  final LogInWithGoogleUseCase logInWithGoogleUseCase;

  LoginCubit({
    required this.logInWithEmailAndPasswordUseCase,
    required this.isLoggedInUseCase,
    required this.authExceptionUseCase,
    required this.logInWithGoogleUseCase,
  }) : super(LoginInitial());

  Future<void> loginWithCredential(String email, String password) async {
    emit(Logging());

    try {
      await logInWithEmailAndPasswordUseCase.call(email, password);
      bool isLoggedIn = await isLoggedInUseCase.call();

      if (isLoggedIn) {
        emit(LoginSuccess());
      } else {
        final message = authExceptionUseCase.call();
        emit(LoginFailure(message: message));
      }
    } catch (e) {
      emit(LoginFailure(message: "Login Failed"));
    }
  }

  Future<void> googleLogin() async {
    emit(Logging());

    try {
      await logInWithGoogleUseCase.call();
      bool isLoggedIn = await isLoggedInUseCase.call();

      if (isLoggedIn) {
        emit(LoginSuccess());
      } else {
        final message = authExceptionUseCase.call();
        emit(LoginFailure(message: message));
      }
    } catch (e) {
      emit(LoginFailure(message: "Login Failed"));
    }
  }
}
