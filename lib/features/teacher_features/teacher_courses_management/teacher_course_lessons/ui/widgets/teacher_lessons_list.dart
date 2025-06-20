import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/teacher_lessons_cubit.dart';
import '../../logic/cubit/teacher_lessons_state.dart';
import 'lesson_outside.dart';

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
