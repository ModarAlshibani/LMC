import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';

class AddQuestionHeader extends StatelessWidget {
  const AddQuestionHeader({
    super.key,
    required this.color,
    required this.title,
    required this.description, required this.icon,
  });

  final Color color;
  final String title;
  final String description;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: double.infinity,
      height: 150.h,
      topLeft: 24.r,
      topRight: 24.r,
      bottomLeft: 24.r,
      bottomRight: 24.r,
      firstColor: color.withOpacity(0.08),
      secondColor: color.withOpacity(0.04),
      firstBlurOpacity: 0.9,
      secondBlurOpacity: 0.6,
      sigmaX: 60,
      sigmaY: 60,
      withBorder: true,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, size: 36.sp, color: Colors.white),
            ),
            horizontalSpace(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "Translation Question",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lmcBlue,
                      height: 1.2,
                    ),
                  ),
                  verticalSpace(4.h),
                  Text(
                    description ?? "Create a sentence translation challenge",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lmcBlue.withOpacity(0.7),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
