import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';


class LessonFlashcardsUsecase {
  final ApiService apiService;

  LessonFlashcardsUsecase(this.apiService);

  Future<List<FlashCards>> execute(int lessonId) async {
    try {

      final lessonFlashcards = await apiService.getLessonFlashcards(lessonId);

      return lessonFlashcards;

    } catch (e) {
      throw Exception('Error getting MyCoursesTeacher: $e');
    }
  }
}
