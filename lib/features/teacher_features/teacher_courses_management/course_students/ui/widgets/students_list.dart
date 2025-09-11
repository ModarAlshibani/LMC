import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/get_students_names_cubit.dart';

import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/ui/widgets/course_flashcards_outside.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_students/ui/widgets/student_outside.dart';

class StudentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStudentsNamesCubit, GetStudentsNamesState>(
      builder: (context, state) {
        if (state is GetStudentsNamesLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is GetStudentsNamesFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state}'));
        } else if (state is GetStudentsNamesSuccess) {
          print("state is: $state");
          final StudentsList = state.getStudentsNames;
          return ListView.builder(
            itemCount: StudentsList.length,
            itemBuilder: (context, index) {
              return StudentOutside(
                students: StudentsList[index],
              );
            },
          );
        }
        return Center(child: Text('No flashcards for this lesson found.'));
      },
    );
  }
}
