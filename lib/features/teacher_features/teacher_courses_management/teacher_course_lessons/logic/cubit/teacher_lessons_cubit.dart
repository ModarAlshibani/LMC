import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/cubit/teacher_lessons_state.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/usecases/teacher_lessons_usescase.dart';

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
