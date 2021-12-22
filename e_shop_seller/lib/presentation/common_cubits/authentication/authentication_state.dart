part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User loggedFirebaseSeller;

  const Authenticated({required this.loggedFirebaseSeller});

  @override
  List<Object> get props => [loggedFirebaseSeller];

  @override
  String toString() {
    return 'Authenticated{email: ${loggedFirebaseSeller.email}}';
  }
}

class Unauthenticated extends AuthenticationState {}
