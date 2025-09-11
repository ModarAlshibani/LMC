import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/usecases/add_final_test_usecase.dart';

part 'add_final_test_state.dart';

class AddFinalTestCubit extends Cubit<AddFinalTestState> {
  final AddFinalTestUseCase addFinalTestUseCase;

  AddFinalTestCubit(this.addFinalTestUseCase) : super(AddFinalTestInitial());

  Future<void> AddFinalTest({
   required int courseId,
    required String title,
    required double duration,
    required double mark,
    required BuildContext context,
  }) async {
    emit(AddFinalTestLoading());

    try {
      await addFinalTestUseCase.execute(
       courseId: courseId,
        title: title,
        duration: duration,
        mark: mark,
        context: context,
      );
      emit(AddFinalTestSuccess());
    } catch (error) {
      print(
        "errrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
      );
      emit(AddFinalTestFailure(error.toString()));
    }
  }
}
