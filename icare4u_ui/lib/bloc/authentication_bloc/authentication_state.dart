part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String email;
  final String userId;
  final String token;

  const Authenticated({
    this.email,
    this.userId,
    this.token,
  });

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'Authenticated { displayName: $email }';
}

class Unauthenticated extends AuthenticationState {}
