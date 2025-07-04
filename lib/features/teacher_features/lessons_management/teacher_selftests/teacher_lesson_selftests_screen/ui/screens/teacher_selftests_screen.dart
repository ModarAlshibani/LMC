import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/guest_features/guest_homePage/ui/widgets/top_container.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/ui/widgets/selftests_list.dart';

class TeacherSelfTestsScreen extends StatelessWidget {
  final int lessonId;

  const TeacherSelfTestsScreen({super.key, required this.lessonId});

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
            top: 80.h,
            left: 50.w,
            right: 50.w,
            child: Center(
              child: Text(
                "Lesson's Selftests",
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          Positioned(
            top: 240.h,
            right: 20.w,
            left: 20.w,
            bottom: 20,
            child: TeacherSelfTestsList(),
          ),

          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lmcOrange,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                highlightColor: AppColors.lmcBlue,
                // onPressed: () => print(lessonId.toString()),
                onPressed:
                    () => Navigator.pushNamed(
                      context,
                      Routes.add_selftest,
                      arguments: lessonId,
                    ),

                icon: Icon(Icons.add, size: 45, color: AppColors.background2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
