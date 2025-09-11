import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class SubmitComplaintUseCase {
  final ApiService apiService;

  SubmitComplaintUseCase(this.apiService);

  Future<void> execute({
    required String subject,
    required BuildContext context,
  }) async {
    try {
      await apiService.SubmitComplaint(
      
        subject: subject,
        context: context,
      );
    } catch (e) {
      throw Exception('Error adding complaint: $e');
    }
  }
}
