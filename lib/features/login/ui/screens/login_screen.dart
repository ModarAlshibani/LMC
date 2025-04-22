import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/extentions.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/general_text_form_field.dart';
import 'package:lmc_app/features/login/ui/widgets/bottom_blur_container.dart';
import 'package:lmc_app/features/login/ui/widgets/login_background.dart';
import 'package:lmc_app/features/login/ui/widgets/welcomeBackText.dart';

import '../../../../core/routing/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          LoginBackground(),
          Positioned(
            top: 62.h,
            left: 0,
            right: 0,
            child: WelcomeBackText(),
          ),
          Positioned(
            bottom: 0.h,
            left: 0,
            right: 0,
            child: BottomBlurContainer(),
          ),
          Positioned(
            bottom: 225.h,
            left: 40.w,
            right: 0,
            child: Text(
              "Enter your credentials to continue:",
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontSize: 16.sp,
              ),
            ),
          ),

          Positioned(
            bottom: 160.h,
            left: 40.w,
            right: 40.w,
            child: GeneralTextFormField(
              hintText: "Email@gmail.com",
              prefixIcon: Icon(
                Icons.email_outlined,
                size: 20.sp,
                color: AppColors.greyBorder,
              ),
            ),
          ),

          Positioned(
            bottom: 100.h,
            left: 40.w,
            right: 40.w,
            child: GeneralTextFormField(
              hintText: "********",
              isObsecureText: true,
              prefixIcon: Icon(
                Icons.vpn_key_outlined,
                size: 20.sp,
                color: AppColors.greyBorder,
              ),
            ),
          ),
          Positioned(
            bottom: 70.h,
            left: 40.w,
            right: 0,
            child: Text(
              "Don't have an account?",
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontSize: 12.sp,
              ),
            ),
          ),
          Positioned(
            bottom: 70.h,
            right: 40.w,
            child: InkWell(
              onTap: () => context.pushNamed(
                Routes.signUp,
              ),
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: AppColors.lmcBlue,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
