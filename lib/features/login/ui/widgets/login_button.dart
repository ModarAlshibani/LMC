import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/helpers/extentions.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/login/data/models/login_request_body.dart';
import 'package:lmc_app/features/login/logic/cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundColor, // Use the lmcorange color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 140.0,
          vertical: 12.0,
        ), // Button padding
      ),
      child: Text(
        "Login",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: AppColors.lmcBlue, // Text color
        ),
      ),
    );
  }
}
