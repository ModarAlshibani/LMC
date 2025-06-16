import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/student_features/my_courses/show_lessons/logic/cubit/lessons_cubit.dart';
import 'package:lmc_app/features/student_features/my_courses/show_lessons/logic/cubit/lessons_state.dart';
import 'package:lmc_app/features/student_features/my_courses/show_lessons/ui/widgets/lesson_outside.dart';

class LessonsList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<LessonsCubit, LessonsState>(
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
              return LessonOutside(
                lesson: myLessons[index],
              );
            },
          );
        }
        return Center(child: Text('No courses found.'));
      },
    ),
    );
  }


}