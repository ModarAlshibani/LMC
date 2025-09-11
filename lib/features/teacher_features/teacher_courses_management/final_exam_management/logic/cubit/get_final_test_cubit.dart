import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/final_test_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/usecases/get_final_test_usecase.dart';

part 'get_final_test_state.dart';

class GetTeacherFinalTestCubit extends Cubit<GetTeacherFinalTestState> {
  final GetTeacherFinalTestUsecase getTeacherFinalTestUsecase;

  GetTeacherFinalTestCubit(this.getTeacherFinalTestUsecase) : super(GetTeacherFinalTestInitial());

  Future<void> fetchFinalTest(int courseId) async {
    print("Fetching final test for courseId: $courseId");
    emit(GetTeacherFinalTestLoading());

    try {
      final finalTest = await getTeacherFinalTestUsecase.execute(courseId);
      print("Final test result: ${finalTest?.toString() ?? 'null'}");
      emit(GetTeacherFinalTestSuccess(finalTest));
    } catch (error) {
      print("Error in cubit: $error");
      emit(GetTeacherFinalTestFailure(error.toString()));
    }
  }
}