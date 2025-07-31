import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest_question/logic/usecase/add_selftest_usecase.dart';

part 'add_selftest_question_state.dart';

class AddSelfTestQuestionCubit extends Cubit<AddSelfTestQuestionState> {
  final AddSelfTestQuestionsUseCase addSelfTestQuestionsUseCase;

  AddSelfTestQuestionCubit(this.addSelfTestQuestionsUseCase)
    : super(AddSelfTestQuestionInitial());

  Future<void> AddSelfTestQuestion({
    required int selfTestId,
    File? media,
    required String questionText,
    required String type,
     List<String>? choices,
    required String correctAnswer,
    required BuildContext context,
  }) async {
    emit(AddSelfTestQuestionLoading());

    try {
      await addSelfTestQuestionsUseCase.execute(
        selfTestId: selfTestId,
        media: media,
        questionText: questionText,
        type: type,
        choices: choices,
        correctAnswer: correctAnswer,
        context: context,
      );
      emit(AddSelfTestQuestionSuccess());
    } catch (error) {
      emit(AddSelfTestQuestionFailure(error.toString()));
    }
  }

  /// 🔁 Emits a state indicating that data should be refreshed in the UI
  void triggerRefresh() {
    emit(AddSelfTestQuestionRefreshing());
  }
}
