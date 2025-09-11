import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class EditComplaintUseCase {
  final ApiService apiService;

  EditComplaintUseCase(this.apiService);

  Future<void> execute({
    required String complaintId,
    required String subject,
    required BuildContext context,
  }) async {
    try {
      await apiService.EditComplaint(
      complaintId: complaintId,
        subject: subject,
        context: context,
      );
    } catch (e) {
      throw Exception('Error adding complaint: $e');
    }
  }
}
