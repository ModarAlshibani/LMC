import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/student_features/certificates/data/certificate_model.dart';

abstract class ViewCertificateState extends Equatable {
  const ViewCertificateState();
  @override
  List<Object?> get props => [];
}

class ViewCertificateInitial extends ViewCertificateState {}

class ViewCertificateLoading extends ViewCertificateState {}

class ViewCertificateSuccess extends ViewCertificateState {
  final CertificateModel certificateModel;
  const ViewCertificateSuccess(this.certificateModel);
  @override
  List<Object?> get props => [certificateModel];
}

class ViewCertificateFailure extends ViewCertificateState {
  final String error;
  final String? message;

  const ViewCertificateFailure(this.error, {this.message});
  @override
  List<Object?> get props => [error, message];
}
