import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/ui/widgets/course_actions_widget.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/ui/widgets/course_header_widget.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/ui/widgets/course_info_card_widget.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/theming/colors.dart';
import '../../data/model/my_courses_teacher_model.dart';

class TeacherMyCourseDetails extends StatelessWidget {
  final MyCourses course;
  final CourseSchedule courseSchedule;

  const TeacherMyCourseDetails({
    super.key,
    required this.course,
    required this.courseSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.lmcBlue.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.background2,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      "Course Details",
                      style: TextStyle(
                        color: AppColors.lmcBlue,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),

                    // Course Header with Image and Basic Info
                    CourseHeaderWidget(course: course),

                    SizedBox(height: 20.h),

                    // Course Information Card
                    CourseInfoCardWidget(
                      course: course,
                      courseSchedule: courseSchedule,
                    ),

                    SizedBox(height: 20.h),

                    // Course Actions
                    CourseActionsWidget(
                      courseId: course.id.toString(),
                      onLessonsPressed:
                          () => Navigator.pushNamed(
                            context,
                            Routes.teacher_lessons_list,
                            arguments: course.id,
                          ),
                      onFinalExamPressed:
                          () => Navigator.pushNamed(
                            context,
                            Routes.teacher_final_test_screen,
                            arguments: course.id,
                          ),
                      onStudentsPressed:
                          () => Navigator.pushNamed(
                            context,
                            Routes.course_students_screen,
                            arguments: course.id,
                          ),
                      onFlashCardsPressed:
                          () => Navigator.pushNamed(
                            context,
                            Routes.course_flashcards_screen,
                            arguments: course.id,
                          ),
                    ),

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
