import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import '../widgets/glass_card.dart';

class NetworkErrorHandler {
  // General method to handle any error type
  static Exception handleError(dynamic error, BuildContext context) {
    String errorMessage = 'An unexpected error occurred. Please try again.';

    if (error is DioException) {
      errorMessage = _handleDioException(error);
    } else if (error is ApiException) {
      errorMessage = error.message;
    } else if (error is NetworkException) {
      errorMessage = error.message;
    } else if (error is Exception) {
      errorMessage = error.toString();
    } else if (error is Error) {
      errorMessage = error.toString();
    }

    _showDialog(context, errorMessage);

    // Always return a generic ApiException for consistency
    return ApiException(errorMessage);
  }

  // Internal: Handling Dio specific errors
  static String _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.cancel:
        return 'Request was canceled.';
      case DioExceptionType.badResponse:
        return _extractMessageFromResponse(e.response) ??
            'Received an invalid response from server.';
      default:
        return 'Network error. Please check your internet connection.';
    }
  }

  // Internal: Try to extract custom message from server response
  static String? _extractMessageFromResponse(Response? response) {
    if (response?.data is Map<String, dynamic>) {
      final data = response?.data as Map<String, dynamic>;
      return data['message'] ?? data['error'] ?? data['detail'];
    }
    return null;
  }

  // Show a beautiful glass dialog
  static void _showDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: GlassContainer(
            width: 350,
            height: 250,
            topLeft: 15,
            topRight: 15,
            bottomRight: 15,
            bottomLeft: 15,
            firstColor: AppColors.lmcOrange,
            secondColor: AppColors.backgroundColor,
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    errorMessage,
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lmcOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 80.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // For external usage
  static String getErrorMessage(Exception exception) {
    if (exception is NetworkException || exception is ApiException) {
      return exception.toString();
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
