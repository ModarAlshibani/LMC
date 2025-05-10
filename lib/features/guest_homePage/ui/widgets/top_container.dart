import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';

class TopContainer extends StatelessWidget {
  final double? height;
  final bool? border;
  const TopContainer({super.key, this.height, this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height!.h ?? 270.h,
      decoration: BoxDecoration(
        color: AppColors.lmcBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(500),
          bottomRight: Radius.circular(500),
        ),

        border: Border.all(
          color: AppColors.lmcOrange.withOpacity(0.95),
          width: border == true ? 20 : 0,
        ),
      ),
    );
  }
}
