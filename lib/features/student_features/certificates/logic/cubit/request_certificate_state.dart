part of 'request_certificate_cubit.dart';

abstract class RequestCertificateState extends Equatable {
  const RequestCertificateState();

  @override
  List<Object?> get props => [];
}

class RequestCertificateInitial extends RequestCertificateState {}

class RequestCertificateLoading extends RequestCertificateState {}

class RequestCertificateSuccess extends RequestCertificateState {

}

class RequestCertificateFailure extends RequestCertificateState {
  final String error;

  const RequestCertificateFailure(this.error);

  @override
  List<Object?> get props => [error];
}