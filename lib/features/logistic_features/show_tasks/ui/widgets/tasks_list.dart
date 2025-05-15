import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/networking/api_constants.dart';

import 'package:lmc_app/features/for_all/announsments/ui/widgets/announcement_outside.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/ui/widgets/tasks_outside.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AllTasksCubit>().fetchAllTasks();
    return BlocBuilder<AllTasksCubit, AllTasksState>(
      builder: (context, state) {
        if (state is AllTasksLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is AllTasksFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is AllTasksSuccess) {
          print("state is: $state");
          // Only show the first 6 Tasks
          final Tasks =
              state.tasks.toList()..sort((a, b) {
                if ((a.status == 'Pending') && (b.status != 'Pending'))
                  return -1;
                if ((a.status != 'Pending') && (b.status == 'Pending'))
                  return 1;
                return 0;
              });
          return ListView.builder(
            padding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            shrinkWrap: true,
            itemCount: Tasks.length,
            itemBuilder: (context, index) {
              return TasksOutside(
                id: Tasks[index].id  ,
                description: Tasks[index].description ?? 'No Content',
                deadline: Tasks[index].deadline.toString() ?? 'No Deadline',
                status: Tasks[index].status ?? '',
                requiresInvoice: Tasks[index].requiresInvoice ,
              );
            },
          );
        }
        return Center(child: Text('No Tasks found.'));
      },
    );
  }
}
