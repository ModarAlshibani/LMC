import 'dart:io';


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/edit_flashcard/logic/usecase/edit_flashcard_usecase.dart';


part 'edit_flashcard_state.dart';

class EditFlashcardCubit extends Cubit<EditFlashcardState> {
  final EditFlashcardUseCase editFlashcardUseCase;

  EditFlashcardCubit(this.editFlashcardUseCase) : super(EditFlashcardInitial());

  Future<void> EditFlashcard({
    required int flashcardId,
    required String content,
    required String translation,
    required BuildContext context,
  }) async {
    emit(EditFlashcardLoading());

    try {
      await editFlashcardUseCase.execute(
        flashcardId: flashcardId,
        content: content,
        translation: translation,
        context: context,
      );
      emit(EditFlashcardSuccess());
    } catch (error) {
      print(
        "errrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
      );
      emit(EditFlashcardFailure(error.toString()));
    }
  }
}
