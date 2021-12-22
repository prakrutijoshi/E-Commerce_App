part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User loggedFirebaseUser;

  const Authenticated({required this.loggedFirebaseUser});

  @override
  List<Object> get props => [loggedFirebaseUser];

  @override
  String toString() {
    return 'Authenticated{email: ${loggedFirebaseUser.email}}';
  }
}

class Unauthenticated extends AuthenticationState {}
