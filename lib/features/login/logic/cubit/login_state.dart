// presentation/cubit/login_state.dart
part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String? token;
  final User? user;

  LoginSuccess({this.token, this.user});

  @override
  List<Object> get props => [token!, user!];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
