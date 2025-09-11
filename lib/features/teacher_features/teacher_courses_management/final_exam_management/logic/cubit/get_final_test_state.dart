part of 'get_final_test_cubit.dart';

abstract class GetTeacherFinalTestState extends Equatable {
  const GetTeacherFinalTestState();

  @override
  List<Object?> get props => [];
}

class GetTeacherFinalTestInitial extends GetTeacherFinalTestState {}

class GetTeacherFinalTestLoading extends GetTeacherFinalTestState {}

class GetTeacherFinalTestSuccess extends GetTeacherFinalTestState {
  final FinalTestModel? getTeacherFinalTest; // Made nullable

  const GetTeacherFinalTestSuccess(this.getTeacherFinalTest);

  @override
  List<Object?> get props => [getTeacherFinalTest];
}

class GetTeacherFinalTestFailure extends GetTeacherFinalTestState {
  final String error;

  const GetTeacherFinalTestFailure(this.error);

  @override
  List<Object?> get props => [error];
}