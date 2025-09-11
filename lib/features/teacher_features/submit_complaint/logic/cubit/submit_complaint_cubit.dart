import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest/logic/usecase/add_selftests_usecase.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/submit_complaints_usecase.dart';

part 'submit_complaint_state.dart';

class SubmitComplaintCubit extends Cubit<SubmitComplaintState> {
  final SubmitComplaintUseCase submitComplaintsUseCase;

  SubmitComplaintCubit(this.submitComplaintsUseCase) : super(SubmitComplaintInitial());

  Future<void> SubmitComplaints({
    required String subject,
    required BuildContext context,
  }) async {
    emit(SubmitComplaintLoading());

    try {
      await submitComplaintsUseCase.execute(
      subject: subject,
        context: context,
      );
      emit(SubmitComplaintSuccess());
    } catch (error) {
      print(
        "errrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
      );
      emit(SubmitComplaintFailure(error.toString()));
    }
  }
}
