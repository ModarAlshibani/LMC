import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/student_my_courses_cubit.dart';
import '../../logic/cubit/student_my_courses_state.dart';
import 'my_course_outside.dart';
  
class MyCoursesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<StudentMyCoursesCubit>().fetchStudentMyCourses();
    return BlocBuilder<StudentMyCoursesCubit, StudentMyCoursesState>(
      builder: (context, state) {
        if (state is StudentMyCoursesLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is StudentMyCoursesFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state}'));
        } else if (state is StudentMyCoursesSuccess) {
          print("state is: $state");
          final myCourses = state.myCoursesStu.toList();
          return ListView.builder(
            itemCount: myCourses.length,
            itemBuilder: (context, index) {
              return MyCourseOutside(
                course: myCourses[index],
              );
            },
          );
        }
        return Center(child: Text('No courses found.'));
      },
    );
  }
}
