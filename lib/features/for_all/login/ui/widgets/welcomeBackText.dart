import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';

class WelcomeBackText extends StatelessWidget {
   const WelcomeBackText({super.key, this.fontSize});

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "WE", style: TextStyle(
              fontSize: fontSize ?? 38.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.backgroundColor,
            ),
            ),
            TextSpan(
              text: "L",
              style: TextStyle(
                fontSize: fontSize ?? 38.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.lmcOrange,
              ),
            ),
            TextSpan(
              text: "CO",
              style: TextStyle(
                fontSize: fontSize ?? 38.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.backgroundColor,
              ),
            ),
            TextSpan(
              text: "M",
              style: TextStyle(
                fontSize: fontSize ?? 38.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.lmcOrange,
              ),
            ),
            TextSpan(
              text: "E",
              style: TextStyle(
                fontSize: fontSize ?? 38.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.backgroundColor,
              ),
            ),
            TextSpan(
              text: " ",
              style: TextStyle(
                fontSize: fontSize ?? 38.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.backgroundColor,
              ),
            ),
            TextSpan(
              text: "BA",
              style: TextStyle(
                fontSize: fontSize ?? 38.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.backgroundColor,
              ),
            ),
            TextSpan(
              text: "C",
              style: TextStyle(
                fontSize: fontSize ?? 38.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.lmcOrange,
              ),
            ),
            TextSpan(
              text: "K",
              style: TextStyle(
                fontSize: fontSize ?? 38.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.backgroundColor,
              ),
            ),
            TextSpan(
              text: "!",
              style: TextStyle(
                fontSize: fontSize ?? 38.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
