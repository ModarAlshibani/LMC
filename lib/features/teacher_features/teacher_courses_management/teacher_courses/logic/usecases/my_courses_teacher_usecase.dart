import '../../../../../../core/networking/api_service.dart';
import '../../data/model/my_courses_teacher_model.dart';

class GetMyCoursesTeacherUseCase {
  final ApiService apiService;

  GetMyCoursesTeacherUseCase(this.apiService);

  Future<List<MyCourses>> execute() async {
    try {
      // Call the API service to get all MyCoursesTeacher
      final MyCoursesTeacher = await apiService.getTeacherCourses();

      // Return the list of MyCoursesTeacher directly
      return MyCoursesTeacher;
    } catch (e) {
      throw Exception('Error getting MyCoursesTeacher: $e');
    }
  }
}
