part of 'add_selftest_question_cubit.dart';

abstract class AddSelfTestQuestionState extends Equatable {
  const AddSelfTestQuestionState();

  @override
  List<Object?> get props => [];
}

class AddSelfTestQuestionInitial extends AddSelfTestQuestionState {}

class AddSelfTestQuestionLoading extends AddSelfTestQuestionState {}

class AddSelfTestQuestionSuccess extends AddSelfTestQuestionState {}

class AddSelfTestQuestionFailure extends AddSelfTestQuestionState {
  final String error;

  const AddSelfTestQuestionFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// 🔁 Refreshing State - indicates that the UI should reload or pull updated data
class AddSelfTestQuestionRefreshing extends AddSelfTestQuestionState {}