import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';

class TodoList extends StatelessWidget {
  final List<Map<String, dynamic>> todos;
  final void Function(int) onToggle;
  final void Function(int) onDelete;

  const TodoList({
    required this.todos,
    required this.onToggle,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text('No tasks added.'));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: CheckboxListTile(
          tileColor: AppColors.background2,
          activeColor: AppColors.lmcBlue,
          title: Text(
            todos[index]['task'],
            style: TextStyle(
              decoration: todos[index]['done'] ? TextDecoration.lineThrough : null,
            ),
          ),
          value: todos[index]['done'],
          onChanged: (_) => onToggle(index),
          secondary: IconButton(
            icon: const Icon(Icons.delete, color: AppColors.lmcOrange),
            onPressed: () => onDelete(index),
          ),
        ),
      ),
    );
  }
}
