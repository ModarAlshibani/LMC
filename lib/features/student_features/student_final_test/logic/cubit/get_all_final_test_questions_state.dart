import 'package:equatable/equatable.dart';

import '../../data/models/all_final_test_questions_model.dart';

abstract class GetAllFinalTestQuestionsState extends Equatable {
  const GetAllFinalTestQuestionsState();

  @override
  List<Object?> get props => [];
}

class GetAllFinalTestQuestionsInitial extends GetAllFinalTestQuestionsState {}

class GetAllFinalTestQuestionsLoading extends GetAllFinalTestQuestionsState {}

class GetAllFinalTestQuestionsSuccess extends GetAllFinalTestQuestionsState {
  final List<Questions> finalTestQuestions;

  const GetAllFinalTestQuestionsSuccess(this.finalTestQuestions);

  @override
  List<Object?> get props => [finalTestQuestions];
}

class GetAllFinalTestQuestionsFailure extends GetAllFinalTestQuestionsState {
  final String error;

  const GetAllFinalTestQuestionsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
