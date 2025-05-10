import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/features/announsments/data/models/all_announsments.dart';
import 'package:lmc_app/features/logistic_app/show_tasks/data/models/all_tasks_model.dart';

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
}
