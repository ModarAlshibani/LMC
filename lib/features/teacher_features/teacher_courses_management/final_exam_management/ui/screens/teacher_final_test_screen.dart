import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/helpers/states_widgets.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/logic/cubit/get_final_test_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/widgets/add_final_test_section.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/widgets/final_test_details_section.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/ui/widgets/teacher_final_test_header.dart';

class TeacherFinalTestScreen extends StatelessWidget {
  final int courseId;

  const TeacherFinalTestScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetTeacherFinalTestCubit>().fetchFinalTest(courseId);
    });

    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            const FinalTestHeader(),
            Expanded(
              child: BlocBuilder<GetTeacherFinalTestCubit, GetTeacherFinalTestState>(
                builder: (context, state) {
                  if (state is GetTeacherFinalTestLoading) {
                    return Center(
                      child: StateWidgets.buildLoadingState(
                        message: "Loading final test...",
                      ),
                    );
                  } else if (state is GetTeacherFinalTestFailure) {
                    return Center(
                      child: StateWidgets.buildErrorState(
                        title: "Something went wrong",
                        subtitle: "Unable to load final test. Please try again later.",
                        onRetry: () {
                          context.read<GetTeacherFinalTestCubit>().fetchFinalTest(courseId);
                        },
                      ),
                    );
                  } else if (state is GetTeacherFinalTestSuccess) {
                    final getTeacherFinalTest = state.getTeacherFinalTest;

                    if (getTeacherFinalTest == null || getTeacherFinalTest.finalTest == null) {
                      return AddFinalTestSection(courseId: courseId);
                    } else {
                      return FinalTestDetailsSection(finalTest: getTeacherFinalTest);
                    }
                  }

                  return Center(
                    child: StateWidgets.buildLoadingState(
                      message: "Preparing to load final test...",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
