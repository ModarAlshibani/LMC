import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/networking/api_constants.dart';

import 'package:lmc_app/features/announsments/ui/widgets/announcement_outside.dart';
import 'package:lmc_app/features/logistic_app/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import 'package:lmc_app/features/logistic_app/show_tasks/ui/widgets/tasks_outside.dart';

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
          final Tasks = state.tasks.toList();
          return ListView.builder(
            itemCount: Tasks.length,
            itemBuilder: (context, index) {
              return TasksOutside(
                taskId: Tasks[index].id.toString() ?? '',
                content: Tasks[index].description ?? 'No Content',
                deadline: Tasks[index].deadline.toString() ?? 'No Deadline',
                status: Tasks[index].status ?? '',
              );
            },
          );
        }
        return Center(child: Text('No Tasks found.'));
      },
    );
  }
}
