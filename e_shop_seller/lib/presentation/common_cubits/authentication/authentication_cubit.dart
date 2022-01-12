import 'package:bloc/bloc.dart';
import '../../../domain/usecases/auth_usecases/log_out_from_google.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/usecases/auth_usecases/is_logged_in_usecase.dart';
import '../../../domain/usecases/auth_usecases/log_out_usecase.dart';
import '../../../domain/usecases/auth_usecases/logged_firebase_seller_usecase.dart';
import '../../../domain/usecases/auth_usecases/send_password_reset_email_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final IsLoggedInUseCase isLoggedInUseCase;
  final LogOutUseCase logOutUseCase;
  final LogOutFromGoogleUseCase logOutFromGoogleUseCase;
  final LoggedFirebaseSellerUseCase loggedFirebaseSellerUseCase;
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase;

  AuthenticationCubit({
    required this.isLoggedInUseCase,
    required this.logOutUseCase,
    required this.logOutFromGoogleUseCase,
    required this.loggedFirebaseSellerUseCase,
    required this.sendPasswordResetEmailUseCase,
  }) : super(AuthenticationInitial());

  Future<void> appStarted() async {
    try {
      bool isLoggedIn = await isLoggedInUseCase.call();

      await Future.delayed(Duration(seconds: 1));

      if (isLoggedIn) {
        final loggedSeller = await loggedFirebaseSellerUseCase.call();
        emit(Authenticated(loggedFirebaseSeller: loggedSeller));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> loggedIn() async {
    final loggedSeller = await loggedFirebaseSellerUseCase.call();
    emit(Authenticated(loggedFirebaseSeller: loggedSeller));
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
