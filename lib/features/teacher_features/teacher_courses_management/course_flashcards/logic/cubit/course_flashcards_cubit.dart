import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/data/course_flashcards_model.dart';

import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/logic/usecase/course_flashcards_usecase.dart';

part 'course_flashcards_state.dart';

class CourseFlashcardsCubit extends Cubit<CourseFlashcardsState> {
  final CourseFlashcardsUsecase courseFlashcardsUsecase;

  CourseFlashcardsCubit(this.courseFlashcardsUsecase) : super(CourseFlashcardsInitial());

  Future<void> fetchLessonFlashcards(int courseId ) async {
    emit(CourseFlashcardsLoading());

    try {
      final courseFlashcards = await courseFlashcardsUsecase.execute(courseId);
      emit(CourseFlashcardsSuccess(courseFlashcards));
    } catch (error) {
      emit(CourseFlashcardsFailure(error.toString()));
    }
  }
}
