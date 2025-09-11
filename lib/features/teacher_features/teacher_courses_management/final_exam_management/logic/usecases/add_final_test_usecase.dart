import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class AddFinalTestUseCase {
  final ApiService apiService;

  AddFinalTestUseCase(this.apiService);

  Future<void> execute({
    required int courseId,
    required String title,
    required double duration,
    required double mark,
    required BuildContext context,
  }) async {
    try {
      await apiService.AddFinalTest(
        courseId: courseId,
        title: title,
        duration: duration,
        mark: mark,
        context: context,
      );
    } catch (e) {
      throw Exception('Error adding FinalTest: $e');
    }
  }
}
