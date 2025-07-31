import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/student_features/notes/data/models/note_model.dart';
import 'package:lmc_app/features/student_features/notes/logic/cubit/note_cubit.dart';

class NotesList extends StatelessWidget {
  final List<Notes> notes;
  final NotesCubit notesCubit;

  const NotesList({
    required this.notes,
    required this.notesCubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return const Center(child: Text('No notes yet.'));
    }

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            tileColor: AppColors.background2,
            title: Text(
              note.content ?? '',
              style: const TextStyle(color: AppColors.lmcBlue),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: AppColors.lmcOrange),
              onPressed: () {
                final noteId = note.id;
                if (noteId != null) {
                  notesCubit.deleteNote(noteId); // ✅ FIXED
                }
              },
            ),
            onTap: () {
              final controller = TextEditingController(text: note.content ?? '');
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text("Edit Note"),
                  content: TextField(
                    controller: controller,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Edit your note...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final updatedText = controller.text.trim();
                        if (updatedText.isNotEmpty) {
                          final updatedNote = Notes(
                            id: note.id,
                            content: updatedText,
                            studentId: note.studentId,
                          );
                          notesCubit.editNote(updatedNote); // ✅ FIXED
                          Navigator.pop(dialogContext);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lmcBlue,
                      ),
                      child: const Text("Save"),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
