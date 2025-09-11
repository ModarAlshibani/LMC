import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/student_features/lessons_management/student_flashcards/logic/cubit/stu_flashcard_cubit.dart';
import 'package:lmc_app/features/student_features/lessons_management/student_flashcards/logic/cubit/stu_flashcard_state.dart';
import 'package:lmc_app/features/student_features/lessons_management/student_flashcards/ui/widgets/lesson_flashcards_outside.dart';

class LessonFlashcardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      LessonFlashcardsCubit,
      LessonFlashcardsState
    >(
      builder: (context, state) {
        if (state is LessonFlashcardsLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is LessonFlashcardsFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state}'));
        } else if (state is LessonFlashcardsSuccess) {
          print("state is: $state");
          final LessonFlashcards =
              state.lessonFlashcards.toList();
          return ListView.builder(
            itemCount: LessonFlashcards.length,
            itemBuilder: (context, index) {
              return LessonFlashcardsOutside(
                flashCard: LessonFlashcards[index],
              );
            },
          );
        }
        return Center(child: Text('No flashcards for this lesson found.'));
      },
    );
  }
}
