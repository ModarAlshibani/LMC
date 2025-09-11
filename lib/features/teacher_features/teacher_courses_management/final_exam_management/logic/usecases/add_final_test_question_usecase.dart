import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class AddFinalTestQuestionsUseCase {
  final ApiService apiService;

  AddFinalTestQuestionsUseCase(this.apiService);

  Future<void> execute({
    required int testId,
    File? media,
    required String questionText,
    required String type,
     List<String>? choices,
    required String correctAnswer,
    required double point,

    required BuildContext context,
  }) async {
    try {
      await apiService.AddFinalTestQuestion(
        testId: testId,
        media: media,
        questionText: questionText,
         type: type,
          choices: choices,
          correctAnswer: correctAnswer,
          point: point,
      context: context,
      );
    } catch (e) {
      throw Exception('Error adding FinalTest question: $e');
    }
  }
}
