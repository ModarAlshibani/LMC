import 'package:flutter/material.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/data/models/tacher_course_lessons_model.dart';

import '../../../../../../core/theming/colors.dart';

class TeacherLessonDetails extends StatelessWidget {
  //   final MyCourses course;
  //   final CourseSchedule courseSchedule;
  final Lessons lesson_details;
  const TeacherLessonDetails({
    super.key,
    required this.lesson_details,
    // required this.course,
    // required this.courseSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(lesson_details.title ?? 'lesson title'),
          Text(lesson_details.date ?? 'lesson date'),
          Text(lesson_details.startTime ?? 'lesson start time'),
          Text(lesson_details.endTime ?? 'lesson end time'),
          Text(lesson_details.courseId.toString()),
          InkWell(
            onTap:
                () => Navigator.pushNamed(
                  context,
                  Routes.teacher_lessons_flashcards,
                  arguments: lesson_details.id,
                ),
            child: Center(
              child: Container(
                color: AppColors.lmcOrange,
                height: 60,
                width: 300,
                child: Center(child: Text("Lesson's Flashcards")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
