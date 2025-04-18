import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';

class Fading extends StatelessWidget {
  const Fading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.17.h, 0.9.h],
          colors: [AppColors.lmcBlue, AppColors.lmcBlue.withOpacity(0.0)],
        ),
      ),
    );
  }
}
