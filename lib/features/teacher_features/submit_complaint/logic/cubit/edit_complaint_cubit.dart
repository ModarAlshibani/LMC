import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/edit_complaint_usecase.dart';

part 'edit_complaint_state.dart';

class EditComplaintCubit extends Cubit<EditComplaintState> {
  final EditComplaintUseCase editComplaintsUseCase;

  EditComplaintCubit(this.editComplaintsUseCase)
    : super(EditComplaintInitial());

  Future<void> EditComplaints({
    required String complaintId,
    required String subject,
    required BuildContext context,
  }) async {
    emit(EditComplaintLoading());

    try {
      await editComplaintsUseCase.execute(
        complaintId: complaintId,
        subject: subject,
        context: context,
      );
      emit(EditComplaintSuccess());
    } catch (error) {
      print("errrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      emit(EditComplaintFailure(error.toString()));
    }
  }
}
