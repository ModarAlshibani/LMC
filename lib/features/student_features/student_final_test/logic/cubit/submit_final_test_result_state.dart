part of 'submit_final_test_result_cubit.dart';

abstract class SubmitFinalTestResultState extends Equatable {
  const SubmitFinalTestResultState();

  @override
  List<Object?> get props => [];
}

class SubmitFinalTestResultInitial extends SubmitFinalTestResultState {}

class SubmitFinalTestResultLoading extends SubmitFinalTestResultState {}

class SubmitFinalTestResultSuccess extends SubmitFinalTestResultState {
  final StuFinalTestResaultModel result;

  const SubmitFinalTestResultSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class SubmitFinalTestResultFailure extends SubmitFinalTestResultState {
  final String error;

  const SubmitFinalTestResultFailure(this.error);

  @override
  List<Object?> get props => [error];
}