part of 'add_final_test_question_cubit.dart';

abstract class AddFinalTestQuestionState extends Equatable {
  const AddFinalTestQuestionState();

  @override
  List<Object?> get props => [];
}

class AddFinalTestQuestionInitial extends AddFinalTestQuestionState {}

class AddFinalTestQuestionLoading extends AddFinalTestQuestionState {}

class AddFinalTestQuestionSuccess extends AddFinalTestQuestionState {}

class AddFinalTestQuestionFailure extends AddFinalTestQuestionState {
  final String error;

  const AddFinalTestQuestionFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// 🔁 Refreshing State - indicates that the UI should reload or pull updated data
class AddFinalTestQuestionRefreshing extends AddFinalTestQuestionState {}