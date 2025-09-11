import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';

class RoadmapHeader extends StatelessWidget {
  final String level;
  final int totalCourses;
  final int remainingCourses;

  const RoadmapHeader({
    super.key,
    required this.level,
    required this.totalCourses,
    required this.remainingCourses,
  });

  String getLevelCategory(String level) {
    if (level.startsWith('A')) return 'Beginner';
    if (level.startsWith('B')) return 'Intermediate';
    if (level.startsWith('C')) return 'Advanced';
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    final currentLevelCategory = getLevelCategory(level);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lmcBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.lmcBlue.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  'Current Level: $level',
                  style: TextStyle(
                    color: AppColors.lmcBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '$currentLevelCategory Level',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lmcBlue,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Complete $remainingCourses courses to reach proficiency',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.greyBorder,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              color: AppColors.lmcBlue.withOpacity(0.2),
            ),
            child: FractionallySizedBox(
              widthFactor: (totalCourses - remainingCourses) / totalCourses,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.r),
                  color: AppColors.lmcBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
