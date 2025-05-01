import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';

class SignupText extends StatelessWidget {
  const SignupText({super.key, this.fontSize});

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "L",
                  style: TextStyle(
                    fontSize: fontSize ?? 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.lmcOrange,
                  ),
                ),
                TextSpan(
                  text: "EARN, ", style: TextStyle(
                  fontSize: fontSize ?? 26.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.lmcBlue,
                ),
                ),

                TextSpan(
                  text: "M",
                  style: TextStyle(
                    fontSize: fontSize ?? 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.lmcOrange,
                  ),
                ),
                TextSpan(
                  text: "ASTER, ",
                  style: TextStyle(
                    fontSize: fontSize ?? 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.lmcBlue,
                  ),
                ),
                TextSpan(
                  text: "C",
                  style: TextStyle(
                    fontSize: fontSize ?? 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.lmcOrange,
                  ),
                ),
                TextSpan(
                  text: "OMMUNICATE",
                  style: TextStyle(
                    fontSize: fontSize ?? 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.lmcBlue,
                  ),
                ),
              ],
            ),
          ),
        ),

        verticalSpace(10.h),
        Text("Start by creating your account.",style: TextStyle(
        fontSize: fontSize ?? 25.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.lmcBlue,
    ),)
      ],
    );
  }
}
