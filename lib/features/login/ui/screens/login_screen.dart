import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/extentions.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/login/logic/cubit/login_cubit.dart';
import 'package:lmc_app/features/login/ui/widgets/bottom_blur_container.dart';
import 'package:lmc_app/features/login/ui/widgets/email_and_password.dart';
import 'package:lmc_app/features/login/ui/widgets/login_background.dart';
import 'package:lmc_app/features/login/ui/widgets/login_bloc_listener.dart';
import 'package:lmc_app/features/login/ui/widgets/login_button.dart';
import 'package:lmc_app/features/login/ui/widgets/welcomeBackText.dart';

import '../../../../core/routing/routes.dart';

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
          LoginBackground(),
          Positioned(top: 62.h, left: 0, right: 0, child: WelcomeBackText()),
          Positioned(
            bottom: 0.h,
            left: 0,
            right: 0,
            child: BottomBlurContainer(),
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
                  EmailAndPassword(emailController: emailController, passwordController: passwordController),
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
                      context.read<LoginCubit>().login(email, password);
                    },
                    textStyle: TextStyle(fontSize: 15),
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
