import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class MarkAttendanceUseCase {
  final ApiService apiService;

  MarkAttendanceUseCase(this.apiService);

  Future<void> execute({
    required int lessonId,
    required int studentId,
    required BuildContext context,
  }) async {
    try {
      await apiService.markAttendance(
        lessonId: lessonId,
       studentId: studentId,
        context: context,
      );
    } catch (e) {
      throw Exception('Error marking attendance: $e');
    }
  }
}
