import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/general_text_form_field.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralTextFormField(
          controller: widget.emailController,
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
          controller: widget.passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Password is required";
            }
          },
          hintText: "Password",
          isObsecureText: isObsecureText,
          prefixIcon: Icon(
            Icons.vpn_key_outlined,
            size: 20,
            color: AppColors.greyBorder,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObsecureText = !isObsecureText;
              });
            },
            child: Icon(
              isObsecureText ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      ],
    );
  }
}
