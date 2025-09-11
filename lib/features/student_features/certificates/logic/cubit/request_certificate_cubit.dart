import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/student_features/certificates/logic/usecase/request_certificate_usecase.dart';


part 'request_certificate_state.dart';

class RequestCertificateCubit extends Cubit<RequestCertificateState> {
  final RequestCertificateUseCase requestCertificatesUseCase;

  RequestCertificateCubit(this.requestCertificatesUseCase)
    : super(RequestCertificateInitial());

  Future<void> requestCertificate({
    required String courseId,
    required BuildContext context,
  }) async {
    emit(RequestCertificateLoading());

    try {
      final result = await requestCertificatesUseCase.execute(
        courseId: courseId,
        context: context,
      );
      emit(RequestCertificateSuccess());
    } catch (error) {
      print("Error submitting final test result: $error");
      emit(RequestCertificateFailure(error.toString()));
    }
  }
}