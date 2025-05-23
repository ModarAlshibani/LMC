part of 'send_invoice_cubit.dart';

abstract class SendInvoiceState extends Equatable {
  const SendInvoiceState();

  @override
  List<Object?> get props => [];
}

class SendInvoiceInitial extends SendInvoiceState {}

class SendInvoiceLoading extends SendInvoiceState {}

class SendInvoiceSuccess extends SendInvoiceState {}

class SendInvoiceFailure extends SendInvoiceState {
  final String error;

  const SendInvoiceFailure(this.error);

  @override
  List<Object?> get props => [error];
}