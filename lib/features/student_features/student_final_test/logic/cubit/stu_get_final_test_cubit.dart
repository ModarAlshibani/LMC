// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/stu_get_final_test_state.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/usecase/stu_get_final_test_usecase.dart';




class StuGetFinalTestCubit extends Cubit<StuGetFinalTestState> {
  final StuGetFinalTestUsecase stuGetFinalTestUsecase;

  StuGetFinalTestCubit(this.stuGetFinalTestUsecase) : super(StuGetFinalTestInitial());

  Future<void> fetchStuGetFinalTest(int courseId) async {
    emit(StuGetFinalTestLoading());

    try {
      final stuGetFinalTestModel = await stuGetFinalTestUsecase.execute(courseId);
      if(! isClosed){emit(StuGetFinalTestSuccess(stuGetFinalTestModel));}
    } catch (error) {
      if(! isClosed){emit(StuGetFinalTestFailure(error.toString()));}
    }
  }
}
