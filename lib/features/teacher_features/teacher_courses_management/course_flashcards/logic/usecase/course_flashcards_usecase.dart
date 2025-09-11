import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/data/course_flashcards_model.dart';

class CourseFlashcardsUsecase {
  final ApiService apiService;

  CourseFlashcardsUsecase(this.apiService);

  Future<CourseFlashcardsModel> execute(int courseId) async {
    try {
      final courseFlashcards = await apiService.getCourseFlashcards(courseId);

      return courseFlashcards;
    } catch (e) {
      throw Exception('Error getting course flashcards: $e');
    }
  }
}
