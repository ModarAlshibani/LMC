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
    this.fillColor,
    this.hintTextStyle, this.inputTextStyle,
  });

  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final bool? isObsecureText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? inputTextStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String?)? validator;
  final Color? fillColor;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: fillColor ?? AppColors.backgroundColor.withOpacity(0),
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.backgroundColor,
                width: 1.3,
              ),
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
        hintStyle:
            hintTextStyle ??
            TextStyle(fontSize: 14.sp, color: AppColors.backgroundColor),
        hintText: hintText ?? "No hint text added",
      ),
      obscureText: isObsecureText ?? false,

      style: inputTextStyle ?? TextStyle(fontSize: 14.sp, color: AppColors.backgroundColor),
      cursorColor: AppColors.backgroundColor,
      validator: (value) {
        return validator!(value);
      },
    );
  }
}
