import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/student_features/student_final_test/data/models/stu_final_test_resault_model.dart';

class SubmitFinalTestResultUseCase {
  final ApiService apiService;

  SubmitFinalTestResultUseCase(this.apiService);

  Future<StuFinalTestResaultModel> execute({
    required String testId,
    required BuildContext context,
  }) async {
    try {
      final result = await apiService.submitFinalTestResult(testId: testId, context: context);
      return result;
    } catch (e) {
      throw Exception('Error submitting Result: $e');
    }
  }
}