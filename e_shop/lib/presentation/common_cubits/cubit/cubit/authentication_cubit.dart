import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/auth_usecases/is_logged_in_usecase.dart';
import '../../../../domain/usecases/auth_usecases/log_out_from_google_usecase.dart';
import '../../../../domain/usecases/auth_usecases/log_out_usecase.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import '../../../../domain/usecases/auth_usecases/send_password_reset_email_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final IsLoggedInUseCase isLoggedInUseCase;
  final LogOutUseCase logOutUseCase;
  final LogOutFromGoogleUseCase logOutFromGoogleUseCase;
  final LoggedFirebaseUserUseCase loggedFirebaseUserUseCase;
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase;

  AuthenticationCubit({
    required this.isLoggedInUseCase,
    required this.logOutUseCase,
    required this.logOutFromGoogleUseCase,
    required this.loggedFirebaseUserUseCase,
    required this.sendPasswordResetEmailUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      bool isLoggedIn = await isLoggedInUseCase.call();

      await Future.delayed(Duration(seconds: 1));

      if (isLoggedIn) {
        final loggedFirebase = await loggedFirebaseUserUseCase.call();
        emit(Authenticated(loggedFirebaseUser: loggedFirebase));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      //await Future.delayed(Duration(seconds: 1));
      emit(Unauthenticated());
    }
  }

  Future<void> loggedIn() async {
    final loggedFirebase = await loggedFirebaseUserUseCase.call();
    emit(Authenticated(loggedFirebaseUser: loggedFirebase));
  }

  Future<void> loggedOut() async {
    await logOutUseCase.call();
    await logOutFromGoogleUseCase.call();
    emit(Unauthenticated());
  }

  Future<void> resetPassword({required String email}) async {
    await sendPasswordResetEmailUseCase.call(email: email);
  }
}
