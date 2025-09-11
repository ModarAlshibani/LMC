import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/ui/widgets/teacher_lesson_flashcards_outside.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/logic/cubit/course_flashcards_cubit.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/ui/widgets/course_flashcards_outside.dart';

class CourseFlashcardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFlashcardsCubit, CourseFlashcardsState>(
      builder: (context, state) {
        if (state is CourseFlashcardsLoading) {
          print("state is: $state");
          return Center(child: CircularProgressIndicator());
        } else if (state is CourseFlashcardsFailure) {
          print("state is: $state");
          return Center(child: Text('Error: ${state}'));
        } else if (state is CourseFlashcardsSuccess) {
          print("state is: $state");
          final CourseFlashcards = state.courseFlashcards.flashCards;
          return ListView.builder(
            itemCount: CourseFlashcards?.length,
            itemBuilder: (context, index) {
              return CourseFlashcardsOutside(
                flashCard: CourseFlashcards![index],
              );
            },
          );
        }
        return Center(child: Text('No flashcards for this lesson found.'));
      },
    );
  }
}
