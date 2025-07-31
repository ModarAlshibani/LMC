import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/usecases/enter_bonus_usecase.dart';

part 'enter_bonus_state.dart';

class EnterBonusCubit extends Cubit<EnterBonusState> {
  final EnterBonusUseCase enterBonusUseCase;

  EnterBonusCubit(this.enterBonusUseCase)
    : super(EnterBonusInitial());

  Future<void> enterBonus({
    required int lessonId,
    required int studentId,
    required double bonus,
    required BuildContext context,
  }) async {
    emit(EnterBonusLoading());

    try {
      await enterBonusUseCase.execute(
        lessonId: lessonId,
        studentId: studentId,
        bonus: bonus,
        context: context,
      );
      emit(EnterBonusSuccess());
    } catch (error) {
      print(
        "Error entering bonus marks: $error",
      );
      emit(EnterBonusFailure(error.toString()));
    }
  }
}