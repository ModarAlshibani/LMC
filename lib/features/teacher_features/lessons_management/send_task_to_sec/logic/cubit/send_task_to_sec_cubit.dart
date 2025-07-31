import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/send_task_to_sec/logic/usecase/send_task_to_sec_usecase.dart';

part 'send_task_to_sec_state.dart';

class SendTaskToSecCubit extends Cubit<SendTaskToSecState> {
  final SendTaskToSecStateUseCase sendTaskToSecStateUseCase;

  SendTaskToSecCubit(this.sendTaskToSecStateUseCase)
    : super(SendTaskToSecStateInitial());

  Future<void> sendTaskToSecState({
    required String description,
    required DateTime deadline,
    required int courseId,
    required int lessonId,
    required BuildContext context,
  }) async {
    emit(SendTaskToSecStateLoading());

    try {
      await sendTaskToSecStateUseCase.execute(
        description: description,
        deadline: deadline,
        courseId: courseId,
        lessonId: lessonId,
        context: context,
      );
      emit(SendTaskToSecStateSuccess());
      Navigator.pop(context);
      
    } catch (error) {
      print("Error sending the task: $error");
      emit(SendTaskToSecStateFailure(error.toString()));
    }
  }
}
