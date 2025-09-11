
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';

abstract class LessonFlashcardsState extends Equatable {
  const LessonFlashcardsState();

  @override
  List<Object?> get props => [];
}

class LessonFlashcardsInitial extends LessonFlashcardsState {}

class LessonFlashcardsLoading extends LessonFlashcardsState {}

class LessonFlashcardsSuccess extends LessonFlashcardsState {
  final List<FlashCards> lessonFlashcards;

  const LessonFlashcardsSuccess(this.lessonFlashcards);

  @override
  List<Object?> get props => [lessonFlashcards];
}

class LessonFlashcardsFailure extends LessonFlashcardsState {
  final String error;

  const LessonFlashcardsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
