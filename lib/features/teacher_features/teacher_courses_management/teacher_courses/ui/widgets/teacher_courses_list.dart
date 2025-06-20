import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Center(child: CircularProgressIndicator());
        } else if (state is MyCoursesTeacherFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state}'));
        } else if (state is MyCoursesTeacherSuccess) {
          print("state is: $state");
          final coursesList = state.MyCoursesTeacher.toList();
          return ListView.builder(
            itemCount: coursesList.length,
            itemBuilder: (context, index) {
              return TeacherCourseOutside(
               
                myCourses: coursesList[index],
                courseSchedule: coursesList[index].courseSchedule![index],
              );
            },
          );
        }
        return Center(child: Text('No courses found.'));
      },
    );
  }
}
