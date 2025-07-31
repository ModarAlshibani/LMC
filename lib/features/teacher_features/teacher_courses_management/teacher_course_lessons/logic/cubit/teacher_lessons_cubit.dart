import 'package:bloc/bloc.dart';

import '../usecases/teacher_lessons_usescase.dart';
import 'teacher_lessons_state.dart';

class TeacherLessonsCubit extends Cubit<TeacherLessonsState> {
  final GetTeacherLessonsUsecase getLessonsUsecase;

  TeacherLessonsCubit(this.getLessonsUsecase) : super(LessonsInitial());

  Future<void> fetchLessons(int courseId) async {
    emit(LessonsLoading());

    try {
      final myLessons = await getLessonsUsecase.execute(courseId);
      emit(LessonsSuccess(myLessons));
    } catch (error) {
      emit(LessonsFailure(error.toString()));
    }
  }
}
