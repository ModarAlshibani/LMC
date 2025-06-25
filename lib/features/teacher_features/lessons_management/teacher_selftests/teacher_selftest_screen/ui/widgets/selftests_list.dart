import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_selftest_screen/logic/cubit/selftests_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_selftests/teacher_selftest_screen/ui/widgets/selftests_outside.dart';

class TeacherSelfTestsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfTestsCubit, SelfTestsState>(
      builder: (context, state) {
        if (state is SelfTestsLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is SelfTestsFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state}'));
        } else if (state is SelfTestsSuccess) {
          print("state is: $state");
          final SelfTests = state.selfTests.toList();
          return ListView.builder(
            itemCount: SelfTests.length,
            itemBuilder: (context, index) {
              return SelfTestsOutside(selfTest: SelfTests[index]);
            },
          );
        }
        return Center(child: Text('No flashcards for this lesson found.'));
      },
    );
  }
}
