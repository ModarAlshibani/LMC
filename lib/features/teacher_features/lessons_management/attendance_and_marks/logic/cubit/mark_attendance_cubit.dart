import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/usecases/mark_attendance_usecase.dart';

part 'mark_attendance_state.dart';

class MarkAttendanceCubit extends Cubit<MarkAttendanceState> {
  final MarkAttendanceUseCase markAttendanceUseCase;

  MarkAttendanceCubit(this.markAttendanceUseCase)
    : super(MarkAttendanceInitial());

  Future<void> markAttendance({
    required int lessonId,
    required int studentId,
    required BuildContext context,
  }) async {
    emit(MarkAttendanceLoading());

    try {
      await markAttendanceUseCase.execute(
        lessonId: lessonId,
        studentId: studentId,
        context: context,
      );
      emit(MarkAttendanceSuccess());
    } catch (error) {
      print(
        "Error marking attendance: $error",
      );
      emit(MarkAttendanceFailure(error.toString()));
    }
  }
}