part of 'get_final_test_questions_cubit.dart';

abstract class GetTeacherFinalTestQuestionsState extends Equatable {
  const GetTeacherFinalTestQuestionsState();

  @override
  List<Object?> get props => [];
}

class GetTeacherFinalTestQuestionsInitial extends GetTeacherFinalTestQuestionsState {}

class GetTeacherFinalTestQuestionsLoading extends GetTeacherFinalTestQuestionsState {}

class GetTeacherFinalTestQuestionsSuccess extends GetTeacherFinalTestQuestionsState {
  final TeacherFinalTestQuestionsModel? getTeacherFinalTestQuestions; // Made nullable

  const GetTeacherFinalTestQuestionsSuccess(this.getTeacherFinalTestQuestions);

  @override
  List<Object?> get props => [getTeacherFinalTestQuestions];
}

class GetTeacherFinalTestQuestionsFailure extends GetTeacherFinalTestQuestionsState {
  final String error;

  const GetTeacherFinalTestQuestionsFailure(this.error);

  @override
  List<Object?> get props => [error];
}