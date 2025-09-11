import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/student_features/lessons_management/student_flashcards/logic/cubit/stu_flashcard_state.dart';
import 'package:lmc_app/features/student_features/lessons_management/student_flashcards/logic/usecases/stu_flashcard_usecase.dart';


class LessonFlashcardsCubit extends Cubit<LessonFlashcardsState> {
  final LessonFlashcardsUsecase lessonFlashcardsUsecase;

  LessonFlashcardsCubit(this.lessonFlashcardsUsecase) : super(LessonFlashcardsInitial());

  Future<void> fetchLessonFlashcards(int lessonId ) async {
    emit(LessonFlashcardsLoading());

    try {
      final lessonFlashcards = await lessonFlashcardsUsecase.execute(lessonId);
      emit(LessonFlashcardsSuccess(lessonFlashcards));
    } catch (error) {
      emit(LessonFlashcardsFailure(error.toString()));
    }
  }
}
