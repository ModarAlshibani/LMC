import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/networking/api_service.dart';

class RequestCertificateUseCase {
  final ApiService apiService;

  RequestCertificateUseCase(this.apiService);

  Future<void> execute({
    required String courseId,
    required BuildContext context,
  }) async {
    try {
      final result = await apiService.requestCertificate(
        courseId: courseId,
        context: context,
      );
    } catch (e) {
      throw Exception('Error submitting Result: $e');
    }
  }
}
