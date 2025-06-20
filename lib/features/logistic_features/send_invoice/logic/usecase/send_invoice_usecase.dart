import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../../../core/networking/api_service.dart';

class SendInvoiceUseCase {
  final ApiService apiService;

  SendInvoiceUseCase(this.apiService);

  Future<void> execute({required int taskId, required double amount, required File image, required BuildContext context,}) async {
    try {
      await apiService.sendInvoice(taskId: taskId, amount: amount, imageFile: image, context: context);
    } catch (e) {
      throw Exception('Error sending invoice: $e');
    }
  }
}
