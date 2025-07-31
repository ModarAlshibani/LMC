import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class AddSelfTestQuestionsUseCase {
  final ApiService apiService;

  AddSelfTestQuestionsUseCase(this.apiService);

  Future<void> execute({
    required int selfTestId,
    File? media,
    required String questionText,
    required String type,
     List<String>? choices,
    required String correctAnswer,

    required BuildContext context,
  }) async {
    try {
      await apiService.AddSelfTestQuestion(
        selfTestId: selfTestId,
        media: media,
        questionText: questionText,
         type: type,
          choices: choices,
          correctAnswer: correctAnswer,
      context: context,
      );
    } catch (e) {
      throw Exception('Error adding SelfTests: $e');
    }
  }
}
