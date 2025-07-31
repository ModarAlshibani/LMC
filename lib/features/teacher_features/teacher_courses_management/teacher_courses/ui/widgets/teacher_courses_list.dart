import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/helpers/states_widgets.dart'; // Assuming this path is correct
import '../../logic/cubit/my_courses_teacher_cubit.dart';
import 'teacher_course_outside.dart';

class TeacherCoursesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<MyCoursesTeacherCubit>().fetchMyCoursesTeacher();
    return BlocBuilder<MyCoursesTeacherCubit, MyCoursesTeacherState>(
      builder: (context, state) {
        if (state is MyCoursesTeacherLoading) {
          print("state is: $state");
          return StateWidgets.buildLoadingState(
            message: "Loading courses...",
          );
        } else if (state is MyCoursesTeacherFailure) {
          print("state is: $state");
          return StateWidgets.buildErrorState(
            title: "Something went wrong",
            subtitle: "Unable to load courses. Please try again later.",
            onRetry: () {
              context.read<MyCoursesTeacherCubit>().fetchMyCoursesTeacher();
            },
          );
        } else if (state is MyCoursesTeacherSuccess) {
          print("state is: $state");
          final coursesList = state.MyCoursesTeacher.toList();

          if (coursesList.isEmpty) {
            return StateWidgets.buildEmptyState(
              title: "No Courses Yet",
              subtitle: "You haven't created any courses yet.",
            );
          }

          return ListView.builder(
            itemCount: coursesList.length,
            itemBuilder: (context, index) {
              return TeacherCourseOutside(
                myCourses: coursesList[index],
                courseSchedule: coursesList[index].courseSchedule!,
              );
            },
          );
        }
        return StateWidgets.buildEmptyState(); // Default empty state if no specific state matches
      },
    );
  }
}


