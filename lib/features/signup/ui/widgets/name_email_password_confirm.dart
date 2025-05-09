import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/general_text_form_field.dart';

class NameEmailPasswordConfirm extends StatefulWidget {
  const NameEmailPasswordConfirm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<NameEmailPasswordConfirm> createState() =>
      _NameEmailPasswordConfirmState();
}

class _NameEmailPasswordConfirmState extends State<NameEmailPasswordConfirm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralTextFormField(
          controller: widget.nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Name is required";
            }
          },
          hintText: "John Doe",
          prefixIcon: Icon(Icons.person, size: 20, color: AppColors.greyBorder),
        ),
        verticalSpace(10.h),
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
            size: 20,
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
          isObsecureText: true,
          prefixIcon: Icon(Icons.lock, size: 20, color: AppColors.greyBorder),
        ),
        verticalSpace(10.h),
        GeneralTextFormField(
          controller: widget.confirmPasswordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Confirm Password is required";
            }
          },
          hintText: "Password confirmation",
          isObsecureText: true,
          prefixIcon: Icon(Icons.lock, size: 20, color: AppColors.greyBorder),
        ),
      ],
    );
  }
}
