import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/ui/widgets/my_courses_list.dart';

class StudentMyCoursesScreen extends StatelessWidget {
  const StudentMyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            // Clean Header Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Row(
                children: [
                  // Profile/Menu Icon
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.lmcBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: AppColors.lmcBlue,
                      size: 24.sp,
                    ),
                  ),

                  SizedBox(width: 16.w),

                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's learn!",
                          style: TextStyle(
                            color: AppColors.lmcBlue.withOpacity(0.7),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "My Courses",
                          style: TextStyle(
                            color: AppColors.lmcBlue,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Notification Icon
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.lmcOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppColors.lmcOrange,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
            // Beautiful Welcome Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lmcBlue.withOpacity(0.8),
                    AppColors.lmcOrange.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lmcBlue.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Continue learning",
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Pick up where you left off and keep growing",
                          style: TextStyle(
                            color: AppColors.backgroundColor.withOpacity(0.9),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Icons.school_outlined,
                      color: AppColors.backgroundColor,
                      size: 32.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // Courses List Section
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Courses",
                      style: TextStyle(
                        color: AppColors.lmcBlue,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Courses List
                    Expanded(child: MyCoursesList()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}