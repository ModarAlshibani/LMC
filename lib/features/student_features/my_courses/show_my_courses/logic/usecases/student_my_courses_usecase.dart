import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/data/models/stu_my_courses_model.dart';

class GetStudentMyCoursesUsecase {
  final ApiService apiService;

  GetStudentMyCoursesUsecase(this.apiService);

  Future<List<MyCoursesStu>> execute() async {
    try {
      // Call the API service to get all availableCourses
      final myCoursesStu = await apiService.getStudentMyCourses();
      print(myCoursesStu);
      print("objectnhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");

      // Return the list of availableCourses directly
      return myCoursesStu;
    } catch (e) {
      throw Exception('Error getting MyCourses: $e');
    }
  }
}
