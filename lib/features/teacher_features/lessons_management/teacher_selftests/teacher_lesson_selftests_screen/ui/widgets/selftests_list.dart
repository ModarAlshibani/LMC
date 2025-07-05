import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/states_widgets.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/logic/cubit/selftests_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/ui/widgets/selftests_outside.dart';

class TeacherSelfTestsList extends StatelessWidget {
  final int lessonId;

  const TeacherSelfTestsList({super.key, required this.lessonId});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfTestsCubit, SelfTestsState>(
      builder: (context, state) {
        if (state is SelfTestsLoading) {
          print("state is: $state");
          return StateWidgets.buildLoadingState(
            message: "Loading self tests...",
          );
        } else if (state is SelfTestsFailure) {
          print("state is: $state");
          return StateWidgets.buildErrorState(
            title: "Something went wrong",
            subtitle: "Unable to load self tests. Please try again later.",
            onRetry: () {
              // Add retry logic here
              context.read<SelfTestsCubit>().fetchSelfTests(lessonId);
            },
          );
        } else if (state is SelfTestsSuccess) {
          print("state is: $state");
          final SelfTests = state.selfTests.toList();

          if (SelfTests.isEmpty) {
            return StateWidgets.buildEmptyState(
              icon: Icons.quiz_outlined,
              title: "No Self Tests Yet",
              subtitle:
                  "Create your first self test to help students practice and assess their knowledge",
              primaryColor: AppColors.lmcBlue,
              secondaryColor: AppColors.lmcOrange,
            );
          }

          return ListView.builder(
            itemCount: SelfTests.length,
            itemBuilder: (context, index) {
              return SelfTestsOutside(selfTest: SelfTests[index]);
            },
          );
        }
        return StateWidgets.buildEmptyState();
      },
    );
  }
}
