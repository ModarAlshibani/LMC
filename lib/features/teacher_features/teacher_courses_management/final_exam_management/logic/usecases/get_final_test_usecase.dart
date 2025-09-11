
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/final_test_model.dart';

class GetTeacherFinalTestUsecase {
  final ApiService apiService;

  GetTeacherFinalTestUsecase(this.apiService);

  Future<FinalTestModel?> execute(int courseId) async {
    try {
      final finalTest = await apiService.getFinalTest(courseId);
      return finalTest; // This can now be null
    } catch (e) {
      throw Exception('Error getting final test: $e');
    }
  }
}