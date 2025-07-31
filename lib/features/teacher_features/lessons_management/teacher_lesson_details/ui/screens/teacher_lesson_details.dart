import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_lesson_details/ui/widgets/info_row.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_lesson_details/ui/widgets/selftest_action_button.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/data/models/tacher_course_lessons_model.dart';

import '../../../../../../core/theming/colors.dart';

class TeacherLessonDetails extends StatelessWidget {
  final Lessons lesson_details;

  const TeacherLessonDetails({super.key, required this.lesson_details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      appBar: AppBar(
        backgroundColor: AppColors.background2,
        elevation: 0,
        title: Text(
          'Lesson Details',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lesson Info Card
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.lmcBlue.withOpacity(0.8),
                                AppColors.lmcBlue.withOpacity(0.6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lmcBlue.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Iconsax.book_saved_copy,
                            color: AppColors.background2,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            lesson_details.title ?? 'Lesson Title',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lmcBlue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    verticalSpace(20),

                    InfoRow(
                      icon: Iconsax.calendar_2_copy,
                      label: 'Date',
                      value: lesson_details.date ?? 'Not specified',
                    ),

                    verticalSpace(12),

                    InfoRow(
                      icon: Iconsax.clock_copy,
                      label: 'Start Time',
                      value: lesson_details.startTime ?? 'Not specified',
                    ),

                    verticalSpace(12),

                    InfoRow(
                      icon: Iconsax.clock,
                      label: 'End Time',
                      value: lesson_details.endTime ?? 'Not specified',
                    ),

                    verticalSpace(12),

                    InfoRow(
                      icon: Iconsax.tag_right_copy,
                      label: 'Course ID',
                      value: lesson_details.courseId?.toString() ?? 'N/A',
                    ),
                  ],
                ),
              ),
            ),

            verticalSpace(30),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'Actions:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lmcBlue,
                ),
              ),
            ),

            verticalSpace(5),

            // Action Buttons
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SelftestActionButton(
                    context: context,
                    icon: Iconsax.flash,
                    title: "Lesson's Flashcards",
                    subtitle: 'Manage flashcards for this lesson',
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          Routes.teacher_lessons_flashcards,
                          arguments: lesson_details.id,
                        ),
                  ),

                  verticalSpace(16),

                  SelftestActionButton(
                    context: context,
                    icon: Iconsax.document_text_copy,
                    title: "Lesson's Selftests",
                    subtitle: 'Manage self-tests for this lesson',
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          Routes.teacher_selftests_screen,
                          arguments: lesson_details.id,
                        ),
                  ),

                  verticalSpace(16),
                  SelftestActionButton(
                    context: context,
                    icon: Iconsax.task,
                    title: "Attendancce and Marks",
                    subtitle: 'Take studens attendence and add extra marks',
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          Routes.attendance_and_marks_screen,
                          arguments: lesson_details,
                        ),
                  ),

                  verticalSpace(16),
                  SelftestActionButton(
                    context: context,
                    icon: Iconsax.send_2_copy,
                    title: "Send a task",
                    subtitle: 'Send a task for this lesson to the secritary',
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          Routes.send_task_to_sec,
                          arguments: lesson_details,
                        ),
                  ),
                ],
              ),
            ),

            verticalSpace(40),
          ],
        ),
      ),
    );
  }
}
