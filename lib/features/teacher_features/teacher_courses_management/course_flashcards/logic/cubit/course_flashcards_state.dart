part of 'course_flashcards_cubit.dart';


abstract class CourseFlashcardsState extends Equatable {
  const CourseFlashcardsState();

  @override
  List<Object?> get props => [];
}

class CourseFlashcardsInitial extends CourseFlashcardsState {}

class CourseFlashcardsLoading extends CourseFlashcardsState {}

class CourseFlashcardsSuccess extends CourseFlashcardsState {
  final CourseFlashcardsModel courseFlashcards;

  const CourseFlashcardsSuccess(this.courseFlashcards);

  @override
  List<Object?> get props => [courseFlashcards];
}

class CourseFlashcardsFailure extends CourseFlashcardsState {
  final String error;

  const CourseFlashcardsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
