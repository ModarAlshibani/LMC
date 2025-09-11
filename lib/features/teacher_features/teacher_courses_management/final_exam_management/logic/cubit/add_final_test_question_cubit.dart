import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/usecases/add_final_test_question_usecase.dart';
part 'add_final_test_question_state.dart';

class AddFinalTestQuestionCubit extends Cubit<AddFinalTestQuestionState> {
  final AddFinalTestQuestionsUseCase addFinalTestQuestionsUseCase;

  AddFinalTestQuestionCubit(this.addFinalTestQuestionsUseCase)
    : super(AddFinalTestQuestionInitial());

  Future<void> AddFinalTestQuestion({
    required int testId,
    File? media,
    required String questionText,
    required String type,
    List<String>? choices,
    required String correctAnswer,
    required double point,

    required BuildContext context,
  }) async {
    emit(AddFinalTestQuestionLoading());

    try {
      await addFinalTestQuestionsUseCase.execute(
        testId: testId,
        media: media,
        questionText: questionText,
        type: type,
        choices: choices,
        correctAnswer: correctAnswer,
        point: point,
        context: context,
      );
      emit(AddFinalTestQuestionSuccess());
    } catch (error) {
      emit(AddFinalTestQuestionFailure(error.toString()));
    }
  }

  void triggerRefresh() {
    emit(AddFinalTestQuestionRefreshing());
  }
}
