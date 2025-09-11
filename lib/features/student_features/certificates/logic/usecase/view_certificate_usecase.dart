import 'package:flutter/material.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/student_features/certificates/data/certificate_model.dart';

class ViewCertificateUsecase {
  final ApiService apiService;

  ViewCertificateUsecase(this.apiService);

  Future<CertificateModel> execute(int courseId, BuildContext context) async {
    try {
      return await apiService.viewCertificate(courseId, context);
    } catch (e) {
      // Re-throw to preserve the API message
      rethrow;
    }
  }
}