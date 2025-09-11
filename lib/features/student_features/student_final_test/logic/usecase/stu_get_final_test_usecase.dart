import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/student_features/student_final_test/data/models/stu_get_final_test_model.dart';

class StuGetFinalTestUsecase {
  final ApiService apiService;

  StuGetFinalTestUsecase(this.apiService);

  Future<StuGetFinalTestModel> execute(int courseId) async {
    try {
      // Call the API service to get all availableCourses
      final stuGetFinalTestModel = await apiService.stuGetFinalTest(courseId);
      print(StuGetFinalTestModel);
      print("objectnhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");

      // Return the list of availableCourses directly
      return stuGetFinalTestModel;
    } catch (e) {
      throw Exception('Error getting MyCourses: $e');
    }
  }
}
