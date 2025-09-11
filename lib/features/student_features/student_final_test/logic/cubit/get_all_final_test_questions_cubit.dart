// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/cubit/get_all_final_test_questions_state.dart';
import 'package:lmc_app/features/student_features/student_final_test/logic/usecase/get_all_final_test_questions_usecase.dart';




class GetAllFinalTestQuestionsCubit extends Cubit<GetAllFinalTestQuestionsState> {
  final GetAllFinalTestQuestionsUsecase getAllFinalTestQuestionsUsecase;

  GetAllFinalTestQuestionsCubit(this.getAllFinalTestQuestionsUsecase) : super(GetAllFinalTestQuestionsInitial());

  Future<void> fetchGetAllFinalTestQuestions(int testId) async {
    emit(GetAllFinalTestQuestionsLoading());

    try {
      final finalTestQuestions = await getAllFinalTestQuestionsUsecase.execute(testId);
      if(! isClosed){emit(GetAllFinalTestQuestionsSuccess(finalTestQuestions));}
    } catch (error) {
      if(! isClosed){emit(GetAllFinalTestQuestionsFailure(error.toString()));}
    }
  }
}
