import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/student_features/student_final_test/data/models/stu_get_final_test_model.dart';


abstract class StuGetFinalTestState extends Equatable {
  const StuGetFinalTestState();

  @override
  List<Object?> get props => [];
}

class StuGetFinalTestInitial extends StuGetFinalTestState {}

class StuGetFinalTestLoading extends StuGetFinalTestState {}

class StuGetFinalTestSuccess extends StuGetFinalTestState {
  final StuGetFinalTestModel stuGetFinalTestModel;

  const StuGetFinalTestSuccess(this.stuGetFinalTestModel);

  @override
  List<Object?> get props => [stuGetFinalTestModel];
}

class StuGetFinalTestFailure extends StuGetFinalTestState {
  final String error;

  const StuGetFinalTestFailure(this.error);

  @override
  List<Object?> get props => [error];
}
