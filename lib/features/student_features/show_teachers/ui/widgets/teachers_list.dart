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
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShowTeachersFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is ShowTeachersSuccess) {
          final teachers = state.teachers; 
          final isOdd = teachers.length % 2 != 0;
          final itemCount = teachers.length ~/ 2 + (isOdd ? 1 : 0); 

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final int firstIndex = index * 2;
              final int secondIndex = firstIndex + 1;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TeacherOutside(teacher: teachers[firstIndex]),
                    const SizedBox(width: 20),
                    if (secondIndex < teachers.length)
                      TeacherOutside(teacher: teachers[secondIndex])
                    else
                      const SizedBox(width: 150), // to maintain alignment
                  ],
                ),
              );
            },
          );
        }

        return const Center(child: Text('No Teachers found.'));
      },
    );
  }
}
