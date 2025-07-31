import '../../../../../../core/networking/api_service.dart';
import '../../data/models/tacher_course_lessons_model.dart';

class GetTeacherLessonsUsecase {
  final ApiService apiService;

  GetTeacherLessonsUsecase(this.apiService);

  Future<List<Lessons>> execute(int courseId) async {
    try {
      // Call the API service to get all availableCourses
      final myLessons = await apiService.getTeacherLessons(courseId);
      print(myLessons);
      print("objectnhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");

      // Return the list of availableCourses directly
      return myLessons;
    } catch (e) {
      throw Exception('Error getting MyCourses: $e');
    }
  }
}
