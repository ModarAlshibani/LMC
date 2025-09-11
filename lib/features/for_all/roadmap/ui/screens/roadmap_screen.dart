import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/custom_app_bar.dart';
import 'package:lmc_app/features/for_all/roadmap/ui/widgets/roadmap_course_card_widget.dart';
import 'package:lmc_app/features/for_all/roadmap/ui/widgets/roadmap_hearder_widget.dart';

class RoadmapScreen extends StatelessWidget {
  final String level;
  const RoadmapScreen({super.key, required this.level});

  // Define all levels in order
  static const List<String> allLevels = [
    'A.1.1',
    'A1.2',
    'A.2.1',
    'A.2.2',
    'B.1.1',
    'B.1.2',
    'B.2.1',
    'B.2.2',
    'C.1.1',
    'C.1.2',
    'C.2.1',
    'C.2.2',
  ];

  List<String> getRequiredCourses() {
    int currentIndex = allLevels.indexOf(level);
    if (currentIndex == -1) return [];
    return allLevels.sublist(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final requiredCourses = getRequiredCourses();

    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Roadmap"),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),

                    RoadmapHeader(
                      level: level,
                      totalCourses: allLevels.length,
                      remainingCourses: requiredCourses.length,
                    ),

                    SizedBox(height: 20.h),

                    ...requiredCourses.asMap().entries.map((entry) {
                      final index = entry.key;
                      final courseLevel = entry.value;
                      final isCurrentLevel = courseLevel == level;

                      return RoadmapCourseCard(
                        courseLevel: courseLevel,
                        index: index,
                        isCurrentLevel: isCurrentLevel,
                      );
                    }).toList(),

                    SizedBox(height: 40.h),
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
