import 'package:flutter/cupertino.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_service.dart';

import '../../../../core/di/shared_pref.dart';
import '../../data/models/login_response.dart';

class LoginUseCase {
  final ApiService apiService;
  final LocalStorage localStorage;

  LoginUseCase(this.apiService, this.localStorage);

  Future<LoginResponse> execute(
    String username,
    String password,
    BuildContext context,
  ) async {
    final response = await apiService.login(username, password, context);

    // Log the response to see what is being returned
    print("Response from API: ${response.data}");

    if (response.statusCode == 200) {
      try {
        // Convert the response data to LoginResponse
        final loginData = LoginResponse.fromJson(response.data);
        // Save token in local storage for future use
        if (loginData.token != null) {
          await localStorage.saveToken(loginData.token!);
          await saveUserToken(loginData.token ?? '');
        }
        print("Login Done");
        return loginData;
      } catch (e) {
        throw Exception('Error processing response: $e');
      }
    } else {
      throw Exception('Login failed: ${response.data['message']}');
    }
  }
}

Future<void> saveUserToken(String token) async {
  await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
}
