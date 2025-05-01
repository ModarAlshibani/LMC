import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/App_button.dart';
import 'package:lmc_app/core/widgets/background.dart';
import 'package:lmc_app/features/signup/logic/cubit/signup_cubit.dart';
import 'package:lmc_app/features/signup/ui/widgets/name_email_password_confirm.dart';
import 'package:lmc_app/features/signup/ui/widgets/signup_bloc_listener.dart';
import 'package:lmc_app/features/signup/ui/widgets/signup_text.dart';

import '../../../login/ui/widgets/bottom_blur_container.dart';

class SignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Background(
            image: "assets/images/students1.jpg",
            color: AppColors.lmcOrange.withOpacity(0.15),
          ),
          Positioned(
            top: 62.h,
            left: 0,
            right: 0,
            child: SignupText(fontSize: 26),
          ),
          Positioned(
            bottom: 0.h,
            left: 0,
            right: 0,
            child: BottomBlurContainer(height: 350.h),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SignupBlocListener(
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
                  verticalSpace(20),

                  NameEmailPasswordConfirm(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ),
                  verticalSpace(10.h),
                  AppTextButton(
                    backgroundColor: AppColors.lmcOrange,
                    buttonText: "Signup",
                    onPressed: () {
                      final name = emailController.text;
                      final email = emailController.text;
                      final password = passwordController.text;
                      context.read<signupCubit>().signup(
                        name,
                        email,
                        password,
                        context,
                      );
                    },
                    textStyle: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 15,
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
