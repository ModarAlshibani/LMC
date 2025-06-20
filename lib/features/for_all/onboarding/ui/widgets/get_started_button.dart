import 'package:flutter/material.dart';

import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          () => context.pushNamed(
            Routes.loginScreen,
          ), // Navigate to the login screen
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lmcOrange, // Use the lmcorange color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 80.0,
          vertical: 12.0,
        ), // Button padding
      ),
      child: Text(
        "Get Started",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color
        ),
      ),
    );
  }
}
