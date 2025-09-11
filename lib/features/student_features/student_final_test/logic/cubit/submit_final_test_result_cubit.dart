import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/usecase/submit_final_test_result_usecase.dart';
import 'package:lmc_app/features/student_features/student_final_test/data/models/stu_final_test_resault_model.dart';

part 'submit_final_test_result_state.dart';

class SubmitFinalTestResultCubit extends Cubit<SubmitFinalTestResultState> {
  final SubmitFinalTestResultUseCase submitFinalTestResultsUseCase;

  SubmitFinalTestResultCubit(this.submitFinalTestResultsUseCase)
    : super(SubmitFinalTestResultInitial());

  Future<void> submitFinalTestResult({
    required String testId,
    required BuildContext context,
  }) async {
    emit(SubmitFinalTestResultLoading());

    try {
      final result = await submitFinalTestResultsUseCase.execute(
        testId: testId,
        context: context,
      );
      emit(SubmitFinalTestResultSuccess(result));
    } catch (error) {
      print("Error submitting final test result: $error");
      emit(SubmitFinalTestResultFailure(error.toString()));
    }
  }
}