import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/usecase/submit_final_test_answer_usecase.dart';

part 'submit_final_test_answer_state.dart';

class SubmitFinalTestAnswerCubit extends Cubit<SubmitFinalTestAnswerState> {
  final SubmitFinalTestAnswerUseCase submitFinalTestAnswersUseCase;

  SubmitFinalTestAnswerCubit(this.submitFinalTestAnswersUseCase)
    : super(SubmitFinalTestAnswerInitial());

  Future<void> SubmitFinalTestAnswer({
    required String testId,
    required String questionId,
    required String answer,
    required BuildContext context,
  }) async {
    emit(SubmitFinalTestAnswerLoading());

    try {
      await submitFinalTestAnswersUseCase.execute(
      testId: testId,
      questionId: questionId,
      answer: answer,
      context: context,
      );
      emit(SubmitFinalTestAnswerSuccess());
    } catch (error) {
      print("errrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      emit(SubmitFinalTestAnswerFailure(error.toString()));
    }
  }
}
