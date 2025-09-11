import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/data/models/my_complaints_model.dart' show Data;


class MyComplaintsUsecase {
  final ApiService apiService;

  MyComplaintsUsecase(this.apiService);

  Future<List<Data>> execute() async {
    try {

      final teacherComplaints = await apiService.getTeacherComplaints();

      return teacherComplaints;

    } catch (e) {
      throw Exception('Error getting MyCoursesTeacher: $e');
    }
  }
}
