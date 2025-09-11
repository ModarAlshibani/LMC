import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class SubmitFinalTestAnswerUseCase {
  final ApiService apiService;

  SubmitFinalTestAnswerUseCase(this.apiService);

  Future<void> execute({
    required String testId,
    required String questionId,
    required String answer,
    required BuildContext context,
  }) async {
    try {
      await apiService.submitFinalTestAnswer(
        testId: testId,
        questionId: questionId,
        answer: answer,
        context: context,
      );
    } catch (e) {
      throw Exception('Error submitting answer: $e');
    }
  }
}
