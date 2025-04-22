import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/login/ui/widgets/login_button.dart';

class GlassContainer extends StatelessWidget {
  GlassContainer({
    super.key,
    required this.width,
    required this.height,
    required this.topLeft,
    required this.topRight,
    required this.bottomRight,
    required this.bottomLeft,
    required this.firstColor,
    required this.secondColor,
  });

  final double width;
  final double height;
  final double topLeft;
  final double topRight;
  final double bottomRight;
  final double bottomLeft;
  final Color firstColor;
  final Color secondColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomRight: Radius.circular(bottomLeft),
          bottomLeft: Radius.circular(bottomRight),
        ),
        gradient: LinearGradient(
          colors: [firstColor.withOpacity(0.15), secondColor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomRight: Radius.circular(bottomLeft),
          bottomLeft: Radius.circular(bottomRight),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(padding: const EdgeInsets.all(16)),
        ),
      ),
    );
  }
}
