import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< Updated upstream:lib/features/logistic_features/show_tasks/ui/widgets/tasks_list.dart
import 'package:lmc_app/features/logistic_features/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/ui/widgets/tasks_outside.dart';
=======
import 'package:lmc_app/features/logistic_app/show_tasks/logic/cubit/cubit/all_tasks_cubit.dart';
import 'package:lmc_app/features/logistic_app/show_tasks/ui/widgets/tasks_outside.dart';
>>>>>>> Stashed changes:lib/features/logistic_app/show_tasks/ui/widgets/tasks_list.dart

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Trigger fetch when the widget builds
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

          // Filter to show only tasks with status 'Pending'
          final pendingTasks =
              state.tasks.where((task) => task.status == 'Pending').toList();

          if (pendingTasks.isEmpty) {
            return Center(child: Text('No pending tasks found.'));
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            shrinkWrap: true,
            itemCount: pendingTasks.length,
            itemBuilder: (context, index) {
              final task = pendingTasks[index];
              return TasksOutside(
                id: task.id,
                description: task.description ?? 'No Content',
                deadline: task.deadline?.toString() ?? 'No Deadline',
                status: task.status ?? '',
                requiresInvoice: task.requiresInvoice,
              );
            },
          );
        }

        return Center(child: Text('No Tasks found.'));
      },
    );
  }
}
