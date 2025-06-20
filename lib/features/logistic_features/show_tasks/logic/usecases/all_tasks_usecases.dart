
import '../../../../../core/networking/api_service.dart';
import '../../data/models/all_tasks_model.dart';

class GetAllTasksUseCase {
  final ApiService apiService;

  GetAllTasksUseCase(this.apiService);

  Future<List<AssignedTasks>> execute() async {
    try {
      // Call the API service to get all Tasks
      final tasks = await apiService.getAllTasks();

      // Return the list of Tasks directly
      return tasks;
    } catch (e) {
      throw Exception('Error getting Tasks: $e');
    }
  }
}
