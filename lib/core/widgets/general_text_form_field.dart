import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';

class GeneralTextFormField extends StatelessWidget {
  const GeneralTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyBorder, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lmcOrange, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: TextStyle(fontSize: 10, color: AppColors.hintBlue),
      ),
    );
  }
}
