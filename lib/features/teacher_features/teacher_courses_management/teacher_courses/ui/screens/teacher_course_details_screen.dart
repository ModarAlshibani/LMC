import 'package:flutter/material.dart';
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
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              course.photo ?? 'assets/images/LMC-LOGO.png',
            ),
          ),
          Text(course.level ?? 'cccc'),
          Text(course.status ?? 'jjjjjj'),
          Text(course.description ?? 'no description added for this course'),
          InkWell(
            onTap:
                () => Navigator.pushNamed(
                  context,
                  Routes.teacher_lessons_list,
                  arguments: course.id,
                ),
            child: Container(
              color: AppColors.lmcOrange,
              height: 100,
              width: 300,
              child: Text("Go to lessons"),
            ),
          ),
        ],
      ),
    );
  }
}
