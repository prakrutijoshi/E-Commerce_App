import 'package:e_shop/presentation/screens/splash/splash_screen.dart';

import '../../../../domain/usecases/auth_usecases/is_logged_in_usecase.dart';
import '../../../../domain/usecases/auth_usecases/log_out_usecase.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final IsLoggedInUseCase isLoggedInUseCase;
  final LogOutUseCase logOutUseCase;
  final LoggedFirebaseUserUseCase loggedFirebaseUserUseCase;

  AuthenticationCubit({
    required this.isLoggedInUseCase,
    required this.logOutUseCase,
    required this.loggedFirebaseUserUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      bool isLoggedIn = await isLoggedInUseCase.call();

      await Future.delayed(Duration(seconds: 5));

      if (isLoggedIn) {
        final loggedFirebase = await loggedFirebaseUserUseCase.call();
        emit(Authenticated(loggedFirebaseUser: loggedFirebase));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> loggedIn() async {
    final loggedFirebase = await loggedFirebaseUserUseCase.call();
    emit(Authenticated(loggedFirebaseUser: loggedFirebase));
  }

  Future<void> loggedOut() async {
    await logOutUseCase.call();
    emit(Unauthenticated());
  }
}
