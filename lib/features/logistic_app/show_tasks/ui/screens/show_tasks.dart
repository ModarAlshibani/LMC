import 'package:flutter/material.dart';
import 'package:lmc_app/features/logistic_app/show_tasks/ui/widgets/tasks_list.dart';

class ShowTasks extends StatelessWidget {
  const ShowTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TasksList(),
      ),
    );
  }
}
