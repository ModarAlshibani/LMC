part of 'selftests_cubit.dart';


abstract class SelfTestsState extends Equatable {
  const SelfTestsState();

  @override
  List<Object?> get props => [];
}

class SelfTestsInitial extends SelfTestsState {}

class SelfTestsLoading extends SelfTestsState {}

class SelfTestsSuccess extends SelfTestsState {
  final List<SelfTests> selfTests;

  const SelfTestsSuccess(this.selfTests);

  @override
  List<Object?> get props => [selfTests];
}

class SelfTestsFailure extends SelfTestsState {
  final String error;

  const SelfTestsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
