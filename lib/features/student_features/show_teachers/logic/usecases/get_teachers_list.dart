import '../../../../../core/networking/api_service.dart';
import '../../data/models/teacher_model.dart';

class GetTeachersListUsecase {
  final ApiService apiService;

  GetTeachersListUsecase(this.apiService);

  Future<List<Teachers>> execute() async {
    try {
      // Call the API service to get all announcements
      final teacher = await apiService.getTeachersList();

      // Return the list of announcements directly
      return teacher;
    } catch (e) {
      throw Exception('Error getting teachers list: $e');
    }
  }
}
