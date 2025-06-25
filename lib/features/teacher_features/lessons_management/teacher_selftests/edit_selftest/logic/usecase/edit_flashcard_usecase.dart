import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class EditFlashcardUseCase {
  final ApiService apiService;

  EditFlashcardUseCase(this.apiService);

  Future<void> execute({
    required int flashcardId,
    required String content,
    required String translation,
    required BuildContext context,
  }) async {
    try {
      await apiService.EditFlashcard(
        flashcardId: flashcardId,
        content: content,
        translation: translation,
        context: context,
      );
    } catch (e) {
      throw Exception('Error Editing flashcard: $e');
    }
  }
}
