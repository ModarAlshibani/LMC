import '../../../../../core/networking/api_service.dart';
import '../../data/models/available_courses_model.dart';

class GetAvailableCoursesUseCase {
  final ApiService apiService;

  GetAvailableCoursesUseCase(this.apiService);

  Future<List<AvailableCourses>> execute() async {
    try {
      // Call the API service to get all availableCourses
      final availableCourses = await apiService.getAvailableCourses();

      // Return the list of availableCourses directly
      return availableCourses;
    } catch (e) {
      throw Exception('Error getting availableCourses: $e');
    }
  }
}
