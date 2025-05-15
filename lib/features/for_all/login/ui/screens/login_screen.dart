import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/App_button.dart';
import '../../../../../core/widgets/background.dart';
import '../../logic/cubit/login_cubit.dart';
import '../widgets/bottom_blur_container.dart';
import '../widgets/email_and_password.dart';
import '../widgets/login_bloc_listener.dart';
import '../widgets/welcomeBackText.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Background(
            image: "assets/images/b.jpg",
            color: AppColors.lmcBlue.withOpacity(0.6),
          ),
          Positioned(top: 62.h, left: 0, right: 0, child: WelcomeBackText()),
          Positioned(
            bottom: 0.h,
            left: 0,
            right: 0,
            child: BottomBlurContainer(height: 270.h),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: LoginBlocListener(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      textAlign: TextAlign.start,
                      "Enter your credentials to continue:",
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  verticalSpace(10.h),
                  EmailAndPassword(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  verticalSpace(10.h),
                  Row(
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontSize: 12.sp,
                        ),
                      ),
                      horizontalSpace(134.w),
                      InkWell(
                        onTap: () => context.pushNamed(Routes.signUp),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: AppColors.lmcBlue,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10.h),
                  AppTextButton(
                    buttonText: "Login",
                    onPressed: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      context.read<LoginCubit>().login(
                        email,
                        password,
                        context,
                      );
                    },
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: AppColors.lmcBlue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  verticalSpace(10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
