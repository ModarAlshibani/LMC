import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/courses/ui/widgets/available_courses_list.dart';
import 'package:lmc_app/features/guest_features/guest_homePage/ui/widgets/top_container.dart';

class AvailableCoursesScreen extends StatelessWidget {
  const AvailableCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: Stack(
        children: [
          Positioned(
            top: -110.h,
            left: -30.w,
            right: -30.w,
            child: TopContainer(height: 300.h, border: true),
          ),

          Positioned(
            top: 90.h,
            left: 50.w,
            right: 50.w,
            child: Center(
              child: Text(
                "Available Courses",
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          Positioned(
            top: 220.h,
            right: 20.w,
            left: 20.w,
            bottom: 20,
            child: AvailableCoursesList(),
          ),
        ],
      ),
    );
  }
}
