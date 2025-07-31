import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/login/data/models/login_response.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object?> get props => [];
}

class MyProfileInitial extends MyProfileState {}

class MyProfileLoading extends MyProfileState {}

class MyProfileSuccess extends MyProfileState {
  final User myInfo;

  const MyProfileSuccess(this.myInfo);

  @override
  List<Object?> get props => [myInfo];
}

class MyProfileFailure extends MyProfileState {
  final String error;

  const MyProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}
