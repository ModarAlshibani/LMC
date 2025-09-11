
part of 'submit_final_test_answer_cubit.dart';

abstract class SubmitFinalTestAnswerState extends Equatable {
  const SubmitFinalTestAnswerState();

  @override
  List<Object?> get props => [];
}

class SubmitFinalTestAnswerInitial extends SubmitFinalTestAnswerState {}

class SubmitFinalTestAnswerLoading extends SubmitFinalTestAnswerState {}

class SubmitFinalTestAnswerSuccess extends SubmitFinalTestAnswerState {
 

}

class SubmitFinalTestAnswerFailure extends SubmitFinalTestAnswerState {
  final String error;

  const SubmitFinalTestAnswerFailure(this.error);

  @override
  List<Object?> get props => [error];
}
