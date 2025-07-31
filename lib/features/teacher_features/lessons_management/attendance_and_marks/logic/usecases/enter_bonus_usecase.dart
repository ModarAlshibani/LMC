import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class EnterBonusUseCase {
  final ApiService apiService;

  EnterBonusUseCase(this.apiService);

  Future<void> execute({
    required int lessonId,
    required int studentId,
    required double bonus,
    required BuildContext context,
  }) async {
    try {
      await apiService.enterBonus(
        lessonId: lessonId,
       studentId: studentId,
       bonus: bonus,
        context: context,
      );
    } catch (e) {
      throw Exception('Error marking attendance: $e');
    }
  }
}
