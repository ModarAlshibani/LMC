import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/login/ui/widgets/bottom_blur_container.dart';
import 'package:lmc_app/features/login/ui/widgets/login_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          LoginBackgroung(),
          Positioned(
            top: 62.h,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Welcome back!",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                  color: AppColors.backgroundColor,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.h,
            left: 0,
            right: 0,
            child: BottomBlurContainer(),
          ),
        ],
      ),
    );
  }
}
