import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/general_text_form_field.dart';

class EmailAndPassword extends StatelessWidget {
  const EmailAndPassword({super.key, required this.emailController, required this.passwordController});
 final TextEditingController emailController;
 final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {

    bool isObsecureText = true;

    return Column(
      children: [
        GeneralTextFormField(
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email is required";
            }
          },
          hintText: "Email@gmail.com",
          prefixIcon: Icon(
            Icons.email_outlined,
            size: 20.sp,
            color: AppColors.greyBorder,
          ),
        ),
        verticalSpace(10.h),
        GeneralTextFormField(
          controller: passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Password is required";
            }
          },
          hintText: "********",
          isObsecureText: isObsecureText,
          prefixIcon: Icon(
            Icons.vpn_key_outlined,
            size: 20,
            color: AppColors.greyBorder,
          ),
          suffixIcon: GestureDetector(
            onTap: () => {isObsecureText = false},
            child: Icon(
              isObsecureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 20,
              color: AppColors.greyBorder,
            ),
          ),
        ),
      ],
    );
  }
}
