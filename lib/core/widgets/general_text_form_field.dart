import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class GeneralTextFormField extends StatelessWidget {
  const GeneralTextFormField({
    super.key,
    this.focusedBorder,
    this.enabledBorder,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isObsecureText,
    this.controller,
    this.validator,
  });

  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final bool? isObsecureText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyBorder, width: 1.3),
              borderRadius: BorderRadius.circular(8.0),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.lmcOrange.withOpacity(0.6),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.greyBorder),
        hintText: hintText ?? "No hint text added",
      ),
      obscureText: isObsecureText ?? false,
      style: TextStyle(fontSize: 14.sp, color: AppColors.backgroundColor),
      cursorColor: AppColors.greyBorder,
      validator: (value){
        return validator!(value);
      },
    );
  }
}
