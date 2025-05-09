import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';

class TopContainer extends StatelessWidget {
  final double? height;
  const TopContainer({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height!.h ?? 270.h,
      decoration: BoxDecoration(
        color: AppColors.lmcBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(300),
          bottomRight: Radius.circular(300),
        ),

        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
    );
  }
}
