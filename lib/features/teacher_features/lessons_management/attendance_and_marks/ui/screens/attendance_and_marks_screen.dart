import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/custom_app_bar.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/get_students_names_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/ui/widgets/header_section.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/ui/widgets/students_attendance_list.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/data/models/tacher_course_lessons_model.dart';

class AttendanceAndMarksScreen extends StatelessWidget {
  final Lessons lesson;

  const AttendanceAndMarksScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            CustomAppBar(title: "Attendance & Marks"),

            // Main Content
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<GetStudentsNamesCubit>().fetchStudentsNames(
                    lesson.id!,
                  );
                },
                color: AppColors.lmcBlue,
                child: Column(
                  children: [
                    // Header Section
                    HeaderSection(lessonDate: lesson.date),

                    // Students List
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: StudentsCardsList(lesson: lesson),
                      ),
                    ),
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
