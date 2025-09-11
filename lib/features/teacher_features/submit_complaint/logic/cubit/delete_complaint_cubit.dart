import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/delete_complaint_usecase.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/logic/usecases/edit_complaint_usecase.dart';

part 'delete_complaint_state.dart';

class DeleteComplaintCubit extends Cubit<DeleteComplaintState> {
  final DeleteComplaintUseCase deleteComplaintsUseCase;

  DeleteComplaintCubit(this.deleteComplaintsUseCase)
    : super(DeleteComplaintInitial());

  Future<void> DeleteComplaints({
    required String complaintId,

    required BuildContext context,
  }) async {
    emit(DeleteComplaintLoading());

    try {
      await deleteComplaintsUseCase.execute(complaintId: complaintId);
      emit(DeleteComplaintSuccess());
    } catch (error) {
      print("errrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      emit(DeleteComplaintFailure(error.toString()));
    }
  }
}
