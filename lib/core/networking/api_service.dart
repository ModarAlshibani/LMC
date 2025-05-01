import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

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
      // Catch DioError specifically and pass it to the centralized error handler
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      // If it's not a DioError, handle it generically (for unexpected cases)
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
      // Catch DioError specifically and pass it to the centralized error handler
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      // If it's not a DioError, handle it generically (for unexpected cases)
      throw NetworkException('An unexpected error occurred.');
    }
  }
}
