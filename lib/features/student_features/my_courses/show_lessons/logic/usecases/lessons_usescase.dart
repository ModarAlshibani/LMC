import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/student_features/my_courses/show_lessons/data/models/lessons_model.dart';

class GetLessonsUsecase {
  final ApiService apiService;

  GetLessonsUsecase(this.apiService);

  Future<List<Lesson>> execute(int courseId) async {
    try {
      // Call the API service to get all availableCourses
      final myLessons = await apiService.getLessons(courseId);
      print(myLessons);
      print("objectnhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");

      // Return the list of availableCourses directly
      return myLessons;
    } catch (e) {
      throw Exception('Error getting MyCourses: $e');
    }
  }
}
