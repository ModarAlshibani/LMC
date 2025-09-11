
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/final_test_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/teacher_final_test_questions_model.dart';

class GetTeacherFinalTestQuestionsUsecase {
  final ApiService apiService;

  GetTeacherFinalTestQuestionsUsecase(this.apiService);

  Future<TeacherFinalTestQuestionsModel?> execute(int testId) async {
    try {
      final FinalTestQuestions = await apiService.getTeacherFinalTestQuestions(testId);
      return FinalTestQuestions; // This can now be null
    } catch (e) {
      throw Exception('Error getting final test: $e');
    }
  }
}