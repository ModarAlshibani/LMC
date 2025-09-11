import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/data/models/teacher_schedule_model.dart';

class GetShowScheduleUseCase {
  final ApiService apiService;

  GetShowScheduleUseCase(this.apiService);

  Future<TeacherScheduleModel> execute(String date) async {
    try {
      final schedule = await apiService.getTeacherSchedule(date);

      return schedule;
    } catch (e) {
      throw Exception('Error getting schedule: $e');
    }
  }
}
