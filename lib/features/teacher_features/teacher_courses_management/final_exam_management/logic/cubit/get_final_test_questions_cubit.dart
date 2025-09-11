import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/final_test_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/teacher_final_test_questions_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/usecases/get_teacher_final_test_questions_usecase.dart';

part 'get_final_test_questions_state.dart';

class GetTeacherFinalTestQuestionsCubit extends Cubit<GetTeacherFinalTestQuestionsState> {
  final GetTeacherFinalTestQuestionsUsecase getTeacherFinalTestQuestionsUsecase;

  GetTeacherFinalTestQuestionsCubit(this.getTeacherFinalTestQuestionsUsecase) : super(GetTeacherFinalTestQuestionsInitial());

  Future<void> fetchFinalTestQuestions(int testId) async {
    print("Fetching final test for testId: $testId");
    emit(GetTeacherFinalTestQuestionsLoading());

    try {
      final FinalTestQuestions = await getTeacherFinalTestQuestionsUsecase.execute(testId);
      print("Final test result: ${FinalTestQuestions?.toString() ?? 'null'}");
      emit(GetTeacherFinalTestQuestionsSuccess(FinalTestQuestions));
    } catch (error) {
      print("Error in cubit: $error");
      emit(GetTeacherFinalTestQuestionsFailure(error.toString()));
    }
  }
}