// lib/features/placement_test/logic/placement_test_api.dart
import 'package:dio/dio.dart';
import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/core/networking/api_constants.dart';

class PlacementTestApi {
  final Dio _dio;
  // final LocalStorage _localStorage; // Add this if you have it as a dependency
  static const String _baseUrl = ApiConstants.baseUrl;

  PlacementTestApi(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors for logging (optional)
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
      ),
    );

    // Add authentication interceptor if needed
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('API Request: ${options.method} ${options.path}');
          handler.next(options);
        },
        onError: (error, handler) {
          print('API Error: ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  Future<Response> getNextQuestion() async {
    try {
      // Get token from local storage
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching next question...");

      final response = await _dio.get(
        '/guest-student/getPTQuestion',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to get next question');
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  Future<Response> submitAnswer({
    required int questionId,
    required int? answerId,
  }) async {
    try {
      // Get token from local storage
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Submitting answer for question $questionId...");

      final response = await _dio.post(
        '/guest-student/submitPTAnswer',
        data: {'QuestionId': questionId, 'SelectedAnswerId': answerId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to submit answer');
      }
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception(
          'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout. Please try again.');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message =
            e.response?.data?['message'] ?? 'Unknown error occurred';
        return Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.unknown:
        if (e.error.toString().contains('SocketException')) {
          return Exception('No internet connection');
        }
        return Exception('Network error: ${e.message}');
      default:
        return Exception('Something went wrong: ${e.message}');
    }
  }
}
