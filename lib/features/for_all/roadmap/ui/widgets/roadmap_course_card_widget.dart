
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';

class RoadmapCourseCard extends StatelessWidget {
  final String courseLevel;
  final int index;
  final bool isCurrentLevel;

  const RoadmapCourseCard({
    super.key,
    required this.courseLevel,
    required this.index,
    required this.isCurrentLevel,
  });

  String getLevelCategory(String level) {
    if (level.startsWith('A')) return 'Beginner';
    if (level.startsWith('B')) return 'Intermediate';
    if (level.startsWith('C')) return 'Advanced';
    return 'Unknown';
  }

  Color getLevelColor(String level) {
    if (level.startsWith('A')) return AppColors.green;
    if (level.startsWith('B')) return AppColors.lmcOrange;
    if (level.startsWith('C')) return AppColors.red;
    return AppColors.greyBorder;
  }

  String getCourseDescription(String level) {
    switch (level) {
      case 'A.1.1':
        return 'Basic vocabulary, simple phrases, personal information';
      case 'A1.2':
        return 'Family, shopping, work, simple conversations';
      case 'A.2.1':
        return 'Past experiences, future plans, opinions';
      case 'A.2.2':
        return 'Describing people, places, experiences in detail';
      case 'B.1.1':
        return 'Complex topics, abstract concepts, workplace communication';
      case 'B.1.2':
        return 'Media comprehension, expressing viewpoints clearly';
      case 'B.2.1':
        return 'Technical discussions, formal presentations';
      case 'B.2.2':
        return 'Complex arguments, professional communication';
      case 'C.1.1':
        return 'Implicit meaning, sophisticated language use';
      case 'C.1.2':
        return 'Academic writing, complex reasoning';
      case 'C.2.1':
        return 'Near-native fluency, cultural nuances';
      case 'C.2.2':
        return 'Complete mastery, professional expertise';
      default:
        return 'Course content to be determined';
    }
  }

  String getEstimatedDuration(String level) {
    if (level.startsWith('A')) return '8-12 weeks';
    if (level.startsWith('B')) return '10-14 weeks';
    if (level.startsWith('C')) return '12-16 weeks';
    return '8-12 weeks';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: isCurrentLevel 
            ? Border.all(color: AppColors.lmcBlue, width: 2.w)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Level indicator
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: isCurrentLevel 
                        ? AppColors.lmcBlue
                        : AppColors.lmcBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isCurrentLevel 
                            ? AppColors.backgroundColor
                            : AppColors.lmcBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            courseLevel,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lmcBlue,
                            ),
                          ),
                          if (isCurrentLevel) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.lmcBlue,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'CURRENT',
                                style: TextStyle(
                                  color: AppColors.backgroundColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        getLevelCategory(courseLevel),
                        style: TextStyle(
                          color: getLevelColor(courseLevel),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Duration
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      color: AppColors.greyBorder,
                      size: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      getEstimatedDuration(courseLevel),
                      style: TextStyle(
                        color: AppColors.greyBorder,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            Text(
              getCourseDescription(courseLevel),
              style: TextStyle(
                color: AppColors.greyBorder,
                fontSize: 13.sp,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}