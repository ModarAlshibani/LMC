import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/for_all/announsments/data/models/all_announsments.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/available_courses/data/models/available_courses_model.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/data/models/all_tasks_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/data/model/my_courses_teacher_model.dart';

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
