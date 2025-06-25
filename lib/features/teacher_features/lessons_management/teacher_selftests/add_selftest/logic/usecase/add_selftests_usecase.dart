import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class AddSelfTestsUseCase {
  final ApiService apiService;

  AddSelfTestsUseCase(this.apiService);

  Future<void> execute({
    required int lessonId,
    required String title,
    required String description,
    required BuildContext context,
  }) async {
    try {
      await apiService.AddSelfTest(
        lessonId: lessonId,
        title: title,
        description: description,
        context: context,
      );
    } catch (e) {
      throw Exception('Error adding SelfTests: $e');
    }
  }
}
