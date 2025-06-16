import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/student_features/show_teachers/ui/widgets/teacher_outside.dart';

import '../../logic/cubit/show_teachers_cubit.dart';

class TeachersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ShowTeachersCubit>().fetchAllTeachers();
    return BlocBuilder<ShowTeachersCubit, ShowTeachersState>(
      builder: (context, state) {
        if (state is ShowTeachersLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is ShowTeachersFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is ShowTeachersSuccess) {
          print("state is: $state");
          // Only show the first 6 announcements
          final teachers = state.teachers.take(6).toList();
          return ListView.builder(
            itemCount: (teachers.length / 2).ceil(),
            itemBuilder: (context, index) {
              final int first = index * 2;
              final int second = index + 1;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TeacherOutside(
                      teacher: teachers[first],
                      ),
                      SizedBox(width: 20,),
                     second <teachers.length
                      ? TeacherOutside(
                        teacher: teachers[second] )
                        : Container(),
                    
                  ],
                ),
              );
            },
          );
        }
        return Center(child: Text('No Teachers  found.'));
      },
    );
  }
}
