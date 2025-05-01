import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/signup/data/signup_response.dart';
import '../../../../core/networking/api_service.dart';

import '../../../../core/di/shared_pref.dart';

class SignupUseCase {
  final ApiService apiService;
  final LocalStorage localStorage;

  SignupUseCase(this.apiService, this.localStorage);

  Future<SignupResponse> execute(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    final response = await apiService.registerGuest(
      name,
      email,
      password,
      context,
    );

    // Log the response to see what is being returned
    print("Response from API: ${response.data}");

    if (response.statusCode == 201) {
      try {
        // Convert the response data to signupResponse
        final signupData = SignupResponse.fromJson(response.data);

        // Save token in local storage for future use
        if (signupData.token != null) {
          await localStorage.saveToken(signupData.token!);
        }

        return signupData;
      } catch (e) {
        throw Exception('Error processing response: $e');
      }
    } else {
      throw Exception('signup failed: ${response.data['message']}');
    }
  }
}
