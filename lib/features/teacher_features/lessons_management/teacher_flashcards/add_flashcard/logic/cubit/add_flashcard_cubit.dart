import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/add_flashcard/logic/usecase/add_flashcard_usecase.dart';

part 'add_flashcard_state.dart';

class AddFlashcardCubit extends Cubit<AddFlashcardState> {
  final AddFlashcardUseCase addFlashcardUseCase;

  AddFlashcardCubit(this.addFlashcardUseCase) : super(AddFlashcardInitial());

  Future<void> AddFlashcard({
    required int lessonId,
    required String content,
    required String translation,
    required BuildContext context,
  }) async {
    emit(AddFlashcardLoading());

    try {
      await addFlashcardUseCase.execute(
        lessonId: lessonId,
        content: content,
        translation: translation,
        context: context,
      );
      emit(AddFlashcardSuccess());
    } catch (error) {
      print(
        "errrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
      );
      emit(AddFlashcardFailure(error.toString()));
    }
  }
}
