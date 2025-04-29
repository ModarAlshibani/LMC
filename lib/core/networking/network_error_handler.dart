// core/networking/network_error_handler.dart

import 'package:dio/dio.dart';
import 'package:lmc_app/core/theming/colors.dart';

class NetworkErrorHandler {
  // This method will handle Dio errors globally
  static Exception handleError(DioException e) {
    // Handling connection timeout and receive timeout
    if (e.type == DioExceptionType.connectionTimeout) {
      return NetworkException('Connection timed out. Please try again.');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return NetworkException('Receive timeout. Please try again.');
    }
    // Handling cancellation of the request
    else if (e.type == DioExceptionType.cancel) {
      return NetworkException('Request was canceled.');
    }
    // Handling response errors like 404 or 500
    else if (e.response != null) {
      // You can handle different HTTP status codes here if needed
      int? statusCode = e.response?.statusCode;
      String errorMessage = 'An error occurred';

      // Extracting the error message from the response body
      if (e.response?.data != null) {
        // Assuming the message is in the 'message' field in the response body
        errorMessage = e.response?.data['error'] ?? errorMessage;
      }

      if (statusCode != null && statusCode >= 500) {
        return ApiException('Server error: $errorMessage. Please try again later.');
      } else if (statusCode != null && statusCode == 404) {
        return ApiException('Requested resource not found: $errorMessage.');
      }
      return ApiException('Error: $errorMessage');
    }
    // Handle other unexpected errors
    else {
      return NetworkException('Network error. Please check your internet connection.');
    }
  }

  // You can also add methods to map different types of errors or customize further
  static String getErrorMessage(Exception exception) {
    if (exception is NetworkException) {
      return exception.message;
    } else if (exception is ApiException) {
      return exception.message;
    }
    return 'An unexpected error occurred. Please try again.';
  }
}

// Custom Exception Classes
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  @override
  String toString() => message;
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}
