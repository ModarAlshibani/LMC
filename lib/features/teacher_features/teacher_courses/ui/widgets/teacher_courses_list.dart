import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/features/for_all/announsments/ui/widgets/announcement_outside.dart';
import 'package:lmc_app/features/for_all/courses/logic/cubit/cubit/available_courses_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses/logic/cubit/my_courses_teacher_cubit.dart';
  
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
              return AnnouncementOutside(
                title: coursesList[index].level ?? 'No Level',
                image: coursesList[index].photo ?.replaceAll(
                  'localhost',
                  ApiConstants.ip,
                ),
                content: coursesList[index].description ?? 'No Content',
              );
            },
          );
        }
        return Center(child: Text('No courses found.'));
      },
    );
  }
}
