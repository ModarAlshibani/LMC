import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';

class AdabtiveTextField extends StatelessWidget {
  const AdabtiveTextField({
    super.key,
    this.focusedBorder,
    this.enabledBorder,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.fillColor,
    this.labelTextStyle,
    this.inputTextStyle,
    this.maxHeight,
  });

  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final TextStyle? inputTextStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String?)? validator;
  final Color? fillColor;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 60.h,
        maxHeight: maxHeight ?? 200.h,
      ),
      child: TextFormField(
        controller: controller,
        minLines: 1,
        maxLines: null,
        expands: false,
        decoration: InputDecoration(
          labelText: labelText ?? "Enter text",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle:
              labelTextStyle ??
              TextStyle(fontSize: 18.sp, color: AppColors.lmcBlue),
          fillColor: fillColor ?? AppColors.backgroundColor.withOpacity(0),
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 14.h,
          ),
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
            borderSide: const BorderSide(color: Colors.red, width: 1.3),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.3),
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        style:
            inputTextStyle ??
            TextStyle(fontSize: 14.sp, color: AppColors.backgroundColor),
        cursorColor: AppColors.backgroundColor,
        validator: validator != null ? (value) => validator!(value) : null,
      ),
    );
  }
}
