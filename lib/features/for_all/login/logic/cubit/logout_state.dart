import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoggingOut extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthLogoutFailed extends AuthState {
  final String error;

  AuthLogoutFailed(this.error);

  @override
  List<Object?> get props => [error];
}
