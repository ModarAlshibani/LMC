import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/routing/routes.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/colors.dart';
import '../../data/models/tacher_course_lessons_model.dart';

class TeacherLessonOutside extends StatelessWidget {
  final TeacherLessons lessons;

  const TeacherLessonOutside({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            Routes.teacher_lessons_details,
            arguments: lessons,
          ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Icon Section
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lmcOrange.withOpacity(0.8),
                    AppColors.lmcOrange.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lmcBlue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.play_lesson,
                color: AppColors.backgroundColor,
                size: 32.sp,
              ),
            ),

            SizedBox(width: 16.w),

            // Main Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lmcOrange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14.sp,
                          color: AppColors.lmcOrange,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          lessons.startTime ?? "Time TBD",
                          style: TextStyle(
                            color: AppColors.lmcOrange,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Lesson Title
                  Text(
                    lessons.title ?? "Lesson Title",
                    style: TextStyle(
                      color: AppColors.lmcBlue,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 8.h),

                  // Date with Icon
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16.sp,
                        color: AppColors.lmcBlue.withOpacity(0.6),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        lessons.date ?? "Date TBD",
                        style: TextStyle(
                          color: AppColors.lmcBlue.withOpacity(0.7),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Right Arrow
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.lmcBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.lmcBlue,
                size: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
