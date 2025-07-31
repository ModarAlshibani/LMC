import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/logic/usecase/taecher_lesson_flashcards_usecase.dart';

part 'teacher_lesson_flashcard_state.dart';

class TeacherLessonFlashcardsCubit extends Cubit<TeacherLessonFlashcardsState> {
  final TeacherLessonFlashcardsUsecase teacherLessonFlashcardsUsecase;

  TeacherLessonFlashcardsCubit(this.teacherLessonFlashcardsUsecase) : super(TeacherLessonFlashcardsInitial());

  Future<void> fetchLessonFlashcards(int lessonId ) async {
    emit(TeacherLessonFlashcardsLoading());

    try {
      final teacherLessonFlashcards = await teacherLessonFlashcardsUsecase.execute(lessonId);
      emit(TeacherLessonFlashcardsSuccess(teacherLessonFlashcards));
    } catch (error) {
      emit(TeacherLessonFlashcardsFailure(error.toString()));
    }
  }
}
