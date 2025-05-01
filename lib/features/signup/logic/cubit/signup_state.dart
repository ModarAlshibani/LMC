// presentation/cubit/signup_state.dart
part of 'signup_cubit.dart';

abstract class signupState extends Equatable {
  @override
  List<Object> get props => [];
}

class signupInitial extends signupState {}

class signupLoading extends signupState {}

class signupSuccess extends signupState {
  final String? token;
  final User? user;

  signupSuccess({this.token, this.user});

  @override
  List<Object> get props => [token!, user!];
}

class signupFailure extends signupState {
  final String error;

  signupFailure({required this.error});

  @override
  List<Object> get props => [error];
}
