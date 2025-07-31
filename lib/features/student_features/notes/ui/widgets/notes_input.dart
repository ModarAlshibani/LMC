import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';

class NotesInput extends StatefulWidget {
  final void Function(String) onAdd;

  const NotesInput({required this.onAdd, super.key});

  @override
  State<NotesInput> createState() => _NotesInputState();
}

class _NotesInputState extends State<NotesInput> {
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
        hintText: 'Write a new note...',
        suffixIcon: IconButton(icon: const Icon(Icons.add), color: AppColors.lmcBlue, onPressed: _submit),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lmcOrange)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lmcBlue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
