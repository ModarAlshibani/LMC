import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmc_app/features/student_features/my_courses/show_lessons/data/models/lessons_model.dart';
import 'package:lmc_app/features/student_features/show_teachers/data/models/teacher_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses/data/model/my_courses_teacher_model.dart';
import 'package:path/path.dart';

import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/features/for_all/announsments/data/models/all_announsments.dart';
import 'package:lmc_app/features/for_all/available_courses/data/models/available_courses_model.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/data/models/all_tasks_model.dart';

import '../../features/student_features/my_courses/show_my_courses/data/models/stu_my_courses_model.dart' hide MyCourses;
import 'api_constants.dart';
import 'network_error_handler.dart';

class ApiService {
  final Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;

  Future<Response> login(
    String username,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await dio.post(
        '$baseUrl/login',
        data: {'email': username, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  Future<Response> registerGuest(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await dio.post(
        '$baseUrl/registerGuest',
        data: {'name': name, 'email': email, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  Future<List<Announcements>> getAllAnnouncements() async {
    try {
      print("inside the get announcements");
      // إرسال الطلب للحصول على جميع الإعلانات من الـ API
      final response = await dio.get(
        '$baseUrl/getAllAnnouncements',
      ); // Adjust endpoint if needed

      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        // تحويل البيانات إلى كائن من AllAnnounsmentsModel
        final data = AllAnnounsmentsModel.fromJson(response.data);
        print("modzzzz:  " + data.announcements.toString());
        return data.announcements ?? [];
      } else {
        throw Exception('Failed to load announcements');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  Future<List<AssignedTasks>> getAllTasks() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("user tokkkkkkkken is: $token");
      print("Fetching assigned tasks...");

      final response = await dio.get(
        '$baseUrl/staff/myTasks',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final allTasksModel = AllTasksModel.fromJson(response.data);
        return allTasksModel.assignedTasks ?? [];
      } else {
        throw Exception('Failed to load tasks');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  Future<Response> markTaskAsDone(int taskId, BuildContext context) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("user tokkkkkkkken is: $token");
      print("marking task $taskId as done...");

      final response = await dio.post(
        '$baseUrl/staff/completeUserTask/$taskId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      return response;
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  // ----------------------------------------------------------------------------
  Future<List<AvailableCourses>> getAvailableCourses() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/guest/viewAvailableCourses',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final coursesModel = AvailableCoursesModel.fromJson(response.data);
        return coursesModel.availableCourses ?? [];
      } else {
        throw Exception('Failed to load available courses');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  Future<Response> sendInvoice({
    required int taskId,
    required double amount,
    required File imageFile,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      final fileName = basename(imageFile.path);

      final formData = FormData.fromMap({
        'TaskId': taskId,
        'Amount': amount,
        'Image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        '$baseUrl/logistic/createInvoice',
        data: formData,
        options: Options(headers: {
           'Accept': 'application/json',
          'Authorization': 'Bearer $token'}),
      );
      markTaskAsDone(taskId, context);
      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  // ----------------------------------------------------------------------------
  //--------------------Teacher Functions---------------------------------------
   Future<List<MyCourses>> getTeacherCourses() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/teacher/reviewMyCourses',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final coursesModel = MyCoursesTeacherModel.fromJson(response.data);
        return coursesModel.myCourses ?? [];
      } else {
        throw Exception('Failed to load your courses');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }




//--------------------------------------------------------------------------  
//--------------------------------------------------------------------------  
//--------------------------------------------------------------------------  
//--------------------------------------------------------------------------
//
  Future<List<Teachers>> getTeachersList() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("user tokkkkkkkken is: $token");
      print("Fetching teachers list...");

      final response = await dio.get(
        '$baseUrl/student/viewTeachers',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print("Raw API response: ${response.data}");
      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        // تحويل البيانات إلى كائن من TeacherModel
        final data = TeacherModel.fromJson(response.data);
        print("modzzzz:  " + data.teachers.toString());
        return data.teachers ?? [];
      } else {
        throw Exception('Failed to load teachers list');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //-------------------------------------
    Future<List<MyCoursesStu>> getStudentMyCourses() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/student/viewEnrolledCourses',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final coursesModelStu = MyCoursesModelStu.fromJson(response.data);
        print('Full API response: ${response.data}');
        return coursesModelStu.myCoursesStu ?? [];
      } else {
        throw Exception('Failed to load available courses');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  
//----------------------------------------------------------------------------------

 Future<List<Lesson>> getLessons(int courseId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Lessons for the $courseId course...");

      final response = await dio.get(
        '$baseUrl/student/viewMyLessons/$courseId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      
      if (response.statusCode == 200) {
        final lessonsModel = LessonsModel.fromJson(response.data);
        print('Full API response: ${response.data}');
        return lessonsModel.myLessons ?? [];
      } else {
        throw Exception('Failed to load lessons');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }
  
  
//----------------------------------------------------------------------------------

  Future<User> getUserName() async{
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final userJson = response.data['user'];
        final userModel = User.fromJson(userJson);
        print("Response data: ${response.data}");
        return User.fromJson(userJson);
      } else {
        throw Exception('Failed to load available courses');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    } 
  }

}
