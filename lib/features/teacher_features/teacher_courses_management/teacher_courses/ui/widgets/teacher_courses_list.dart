import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/helpers/states_widgets.dart';
import '../../data/model/my_courses_teacher_model.dart';
import '../../logic/cubit/my_courses_teacher_cubit.dart';
import 'teacher_course_outside.dart';

class TeacherCoursesList extends StatelessWidget {
  final String query;
  const TeacherCoursesList({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    // ❌ Don’t refetch inside build; initState in screen already does that.
    // context.read<MyCoursesTeacherCubit>().fetchMyCoursesTeacher();

    return BlocBuilder<MyCoursesTeacherCubit, MyCoursesTeacherState>(
      builder: (context, state) {
        if (state is MyCoursesTeacherLoading || state is MyCoursesTeacherInitial) {
          return StateWidgets.buildLoadingState(message: "Loading courses...");
        }

        if (state is MyCoursesTeacherFailure) {
          return StateWidgets.buildErrorState(
            title: "Something went wrong",
            subtitle: "Unable to load courses. Please try again later.",
            onRetry: () {
              context.read<MyCoursesTeacherCubit>().fetchMyCoursesTeacher();
            },
          );
        }

        if (state is MyCoursesTeacherSuccess) {
          // Adjust this field name to match your state (you used MyCoursesTeacher before)
          final List<MyCourses> coursesList = state.MyCoursesTeacher.toList();

          // Filtering logic
          final q = query.trim().toLowerCase();
          bool matches(MyCourses c) {
            if (q.isEmpty) return true;
            final level = (c.level ?? '').toLowerCase();
            final desc  = (c.description ?? '').toLowerCase();
            // add more searchable fields if you like
            return level.contains(q) || desc.contains(q);
          }

          final filtered = q.isEmpty ? coursesList : coursesList.where(matches).toList();

          if (filtered.isEmpty) {
            return StateWidgets.buildEmptyState(
              title: "No results found",
              subtitle: "Try a different search term.",
            );
          }

          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final course = filtered[index];
              return TeacherCourseOutside(
                myCourses: course,
                courseSchedule: course.courseSchedule!,
              );
            },
          );
        }

        // Default
        return StateWidgets.buildEmptyState();
      },
    );
  }
}
