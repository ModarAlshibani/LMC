import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../usecase/send_invoice_usecase.dart';

part 'send_invoice_state.dart';

class SendInvoiceCubit extends Cubit<SendInvoiceState> {
  final SendInvoiceUseCase sendInvoiceUseCase;

  SendInvoiceCubit(this.sendInvoiceUseCase) : super(SendInvoiceInitial());

  Future<void> sendInvoice({required int taskId, required double amount, required File image, required BuildContext context,}) async {
    emit(SendInvoiceLoading());

    try {
      await sendInvoiceUseCase.execute(taskId: taskId, amount: amount, image: image, context: context);
      emit(SendInvoiceSuccess());
    } catch (error) {
      print("errrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      emit(SendInvoiceFailure(error.toString()));
    }
  }
}