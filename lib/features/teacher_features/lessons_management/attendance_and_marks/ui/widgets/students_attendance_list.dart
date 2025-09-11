import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/states_widgets.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/get_students_names_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/mark_attendance_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/logic/cubit/enter_bonus_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/ui/widgets/student_attendance_card_outside.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/data/models/tacher_course_lessons_model.dart';

class StudentsCardsList extends StatelessWidget {
  final TeacherLessons lesson;

  const StudentsCardsList({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStudentsNamesCubit, GetStudentsNamesState>(
      builder: (context, state) {
        if (state is GetStudentsNamesLoading) {
          print("state is: $state");
          return StateWidgets.buildLoadingState(message: "Loading students...");
        } else if (state is GetStudentsNamesFailure) {
          print("state is: $state");
          return StateWidgets.buildErrorState(
            title: "Something went wrong",
            subtitle: "Unable to load students. Please try again later.",
            onRetry: () {
              // Retry logic
              context.read<GetStudentsNamesCubit>().fetchStudentsNames(
                lesson.courseId!,
              );
            },
          );
        } else if (state is GetStudentsNamesSuccess) {
          print("state is: $state");
          final students = state.getStudentsNames;

          if (students.isEmpty) {
            return StateWidgets.buildEmptyState(
              icon: Icons.people_outline,
              title: "No Students Yet",
              subtitle: "No students are enrolled in this course",
              primaryColor: AppColors.lmcBlue,
              secondaryColor: AppColors.lmcOrange,
            );
          }

          return MultiBlocListener(
            listeners: [
              BlocListener<MarkAttendanceCubit, MarkAttendanceState>(
                listener: (context, state) {
                  if (state is MarkAttendanceSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Attendance marked successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is MarkAttendanceFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to mark attendance: ${state.error}',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              BlocListener<EnterBonusCubit, EnterBonusState>(
                listener: (context, state) {
                  if (state is EnterBonusSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Bonus marks added successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is EnterBonusFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to add bonus marks: ${state.error}',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ],
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: students.length,
              itemBuilder: (context, index) {
                return StudentAttendanceCard(
                  student: students[index],
                  onSendAttendance: (studentId, isPresent, bonusMarks) async {
                    if (isPresent) {
                      await context.read<MarkAttendanceCubit>().markAttendance(
                        lessonId: lesson.id!,
                        studentId: studentId,
                        context: context,
                      );
                    }
                    if (bonusMarks > 0) {
                      await context.read<EnterBonusCubit>().enterBonus(
                        lessonId: lesson.id!,
                        studentId: studentId,
                        bonus: bonusMarks,
                        context: context,
                      );
                    }
                  },
                );
              },
            ),
          );
        }
        return StateWidgets.buildEmptyState();
      },
    );
  }
}
