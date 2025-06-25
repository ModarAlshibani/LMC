part of 'add_selftest_cubit.dart';

abstract class AddSelfTestState extends Equatable {
  const AddSelfTestState();

  @override
  List<Object?> get props => [];
}

class AddSelfTestInitial extends AddSelfTestState {}

class AddSelfTestLoading extends AddSelfTestState {}

class AddSelfTestSuccess extends AddSelfTestState {}

class AddSelfTestFailure extends AddSelfTestState {
  final String error;

  const AddSelfTestFailure(this.error);

  @override
  List<Object?> get props => [error];
}
