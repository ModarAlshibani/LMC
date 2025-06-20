import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class AddFlashcardUseCase {
  final ApiService apiService;

  AddFlashcardUseCase(this.apiService);

  Future<void> execute({
    required int lessonId,
    required String content,
    required String translation,
    required BuildContext context,
  }) async {
    try {
      await apiService.AddFlashcard(
        lessonId: lessonId,
        content: content,
        translation: translation,
        context: context,
      );
    } catch (e) {
      throw Exception('Error adding flashcard: $e');
    }
  }
}
