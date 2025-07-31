import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/add_selftest/logic/usecase/add_selftests_usecase.dart';

part 'add_selftest_state.dart';

class AddSelfTestCubit extends Cubit<AddSelfTestState> {
  final AddSelfTestsUseCase addSelfTestsUseCase;

  AddSelfTestCubit(this.addSelfTestsUseCase) : super(AddSelfTestInitial());

  Future<void> AddSelfTests({
    required int lessonId,
    required String title,
    required String description,
    required BuildContext context,
  }) async {
    emit(AddSelfTestLoading());

    try {
      await addSelfTestsUseCase.execute(
        lessonId: lessonId,
        title: title,
        description: description,
        context: context,
      );
      emit(AddSelfTestSuccess());
    } catch (error) {
      print(
        "errrrrrrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
      );
      emit(AddSelfTestFailure(error.toString()));
    }
  }
}
