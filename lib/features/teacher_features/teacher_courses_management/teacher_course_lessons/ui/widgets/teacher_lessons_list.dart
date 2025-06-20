import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/theming/colors.dart';

import 'package:lmc_app/features/student_features/my_courses/show_lessons/ui/widgets/lesson_outside.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/cubit/teacher_lessons_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/cubit/teacher_lessons_state.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/ui/widgets/lesson_outside.dart';

class TeacherLessonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherLessonsCubit, TeacherLessonsState>(
      builder: (context, state) {
        if (state is LessonsLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is LessonsFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state}'));
        } else if (state is LessonsSuccess) {
          print("state is: $state");
          final myLessons = state.myLessons.toList();
          return ListView.builder(
            itemCount: myLessons.length,
            itemBuilder: (context, index) {
              return TeacherLessonOutside(lessons: myLessons[index]);
            },
          );
        }
        return Center(child: Text('No courses found.'));
      },
    );
  }
}
