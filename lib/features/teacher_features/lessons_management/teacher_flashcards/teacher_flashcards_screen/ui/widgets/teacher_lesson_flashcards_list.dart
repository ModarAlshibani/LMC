import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/logic/cubit/teacher_lesson_flashcard_cubit.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/ui/widgets/teacher_lesson_flashcards_outside.dart';

class TeacherLessonFlashcardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      TeacherLessonFlashcardsCubit,
      TeacherLessonFlashcardsState
    >(
      builder: (context, state) {
        if (state is TeacherLessonFlashcardsLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is TeacherLessonFlashcardsFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state}'));
        } else if (state is TeacherLessonFlashcardsSuccess) {
          print("state is: $state");
          final TeacherLessonFlashcards =
              state.teacherLessonFlashcards.toList();
          return ListView.builder(
            itemCount: TeacherLessonFlashcards.length,
            itemBuilder: (context, index) {
              return TeacherLessonFlashcardsOutside(
                flashCard: TeacherLessonFlashcards[index],
              );
            },
          );
        }
        return Center(child: Text('No flashcards for this lesson found.'));
      },
    );
  }
}
