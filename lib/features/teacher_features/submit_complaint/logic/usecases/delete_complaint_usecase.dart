import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class DeleteComplaintUseCase {
  final ApiService apiService;

  DeleteComplaintUseCase(this.apiService);

  Future<void> execute({
    required String complaintId,

  }) async {
    try {
      await apiService.deleteComplaint(
       complaintId.toString(),
 
      );
    } catch (e) {
      throw Exception('Error adding complaint: $e');
    }
  }
}
