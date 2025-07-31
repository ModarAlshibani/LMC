import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';

class TodoInput extends StatefulWidget {
  final void Function(String) onAdd;

  const TodoInput({required this.onAdd, super.key});

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onAdd(_controller.text.trim());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Add a task...',
        suffixIcon: IconButton(icon: const Icon(Icons.add_task), color: AppColors.lmcBlue,onPressed: _submit),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lmcBlue, width: 2), // 👈 focused color
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
