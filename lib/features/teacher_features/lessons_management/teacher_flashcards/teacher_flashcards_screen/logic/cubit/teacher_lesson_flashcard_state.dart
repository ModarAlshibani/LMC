part of 'teacher_lesson_flashcard_cubit.dart';


abstract class TeacherLessonFlashcardsState extends Equatable {
  const TeacherLessonFlashcardsState();

  @override
  List<Object?> get props => [];
}

class TeacherLessonFlashcardsInitial extends TeacherLessonFlashcardsState {}

class TeacherLessonFlashcardsLoading extends TeacherLessonFlashcardsState {}

class TeacherLessonFlashcardsSuccess extends TeacherLessonFlashcardsState {
  final List<FlashCards> teacherLessonFlashcards;

  const TeacherLessonFlashcardsSuccess(this.teacherLessonFlashcards);

  @override
  List<Object?> get props => [teacherLessonFlashcards];
}

class TeacherLessonFlashcardsFailure extends TeacherLessonFlashcardsState {
  final String error;

  const TeacherLessonFlashcardsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
