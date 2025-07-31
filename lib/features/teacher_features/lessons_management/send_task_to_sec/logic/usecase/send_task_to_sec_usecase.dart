import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class SendTaskToSecStateUseCase {
  final ApiService apiService;

  SendTaskToSecStateUseCase(this.apiService);

  Future<void> execute({
    required String description,
    required DateTime deadline,
    required int courseId,
    required int lessonId,
    required BuildContext context,
  }) async {
    try {
      await apiService.sendTaskToSec(
        description: description,
        deadline: deadline,
        courseId: courseId,
        lessonId: lessonId,
        context: context,
      );
    } catch (e) {
      throw Exception('Error sending the task: $e');
    }
  }
}
