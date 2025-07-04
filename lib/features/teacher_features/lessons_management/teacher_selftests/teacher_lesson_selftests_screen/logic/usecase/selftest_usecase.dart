import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';


class SelfTestsUsecase {
  final ApiService apiService;

  SelfTestsUsecase(this.apiService);

  Future<List<SelfTests>> execute(int lessonId) async {
    try {

      final selfTests = await apiService.getSelfTests(lessonId);

      return selfTests;

    } catch (e) {
      throw Exception('Error getting MyCoursesTeacher: $e');
    }
  }
}
