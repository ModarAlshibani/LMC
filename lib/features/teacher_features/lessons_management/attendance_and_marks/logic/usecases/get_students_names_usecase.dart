import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/data/models/course_student_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';


class GetStudentsNamesUsecase {
  final ApiService apiService;

  GetStudentsNamesUsecase(this.apiService);

  Future<List<Students>> execute(int lessonId) async {
    try {

      final getStudentsNames = await apiService.getCourseStudents(lessonId);

      return getStudentsNames;

    } catch (e) {
      throw Exception('Error getting MyCoursesTeacher: $e');
    }
  }
}
