import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/for_all/announsments/data/models/all_announsments.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/available_courses/data/models/available_courses_model.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/data/models/all_tasks_model.dart';

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
