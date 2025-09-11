import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:lmc_app/core/networking/network_error_handler.dart';
import 'package:lmc_app/features/student_features/certificates/logic/cubit/view_certificate_state.dart';
import 'package:lmc_app/features/student_features/certificates/logic/usecase/view_certificate_usecase.dart';

class ViewCertificateCubit extends Cubit<ViewCertificateState> {
  final ViewCertificateUsecase viewCertificateUsecase;

  ViewCertificateCubit(this.viewCertificateUsecase) : super(ViewCertificateInitial());

  Future<void> fetchViewCertificate(int courseId, BuildContext context) async {
    emit(ViewCertificateLoading());

    try {
      final viewCertificateModel = await viewCertificateUsecase.execute(courseId, context);
      if (!isClosed) {
        emit(ViewCertificateSuccess(viewCertificateModel));
      }
    } catch (error) {
      if (!isClosed) {
        // Use your existing NetworkErrorHandler to extract the message
        String userMessage = NetworkErrorHandler.extractErrorMessage(error);
        
        emit(ViewCertificateFailure(
          error.toString(), 
          message: userMessage,
        ));
      }
    }
  }
}