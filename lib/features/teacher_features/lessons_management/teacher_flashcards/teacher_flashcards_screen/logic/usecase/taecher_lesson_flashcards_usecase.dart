import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';


class TeacherLessonFlashcardsUsecase {
  final ApiService apiService;

  TeacherLessonFlashcardsUsecase(this.apiService);

  Future<List<FlashCards>> execute(int lessonId) async {
    try {

      final teacherLessonFlashcards = await apiService.getTeacherLessonFlashcards(lessonId);

      return teacherLessonFlashcards;

    } catch (e) {
      throw Exception('Error getting MyCoursesTeacher: $e');
    }
  }
}
