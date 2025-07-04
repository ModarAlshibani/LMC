import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/logic/usecase/selftest_usecase.dart';

part 'selftests_state.dart';

class SelfTestsCubit extends Cubit<SelfTestsState> {
  final SelfTestsUsecase selfTestsUsecase;

  SelfTestsCubit(this.selfTestsUsecase) : super(SelfTestsInitial());

  Future<void> fetchSelfTests(int lessonId ) async {
    emit(SelfTestsLoading());

    try {
      final selfTests = await selfTestsUsecase.execute(lessonId);
      emit(SelfTestsSuccess(selfTests));
    } catch (error) {
      emit(SelfTestsFailure(error.toString()));
    }
  }
}
