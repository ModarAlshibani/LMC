import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/student_features/my_courses/show_lessons/logic/cubit/lessons_state.dart';
import 'package:lmc_app/features/student_features/my_courses/show_lessons/logic/usecases/lessons_usescase.dart';



class LessonsCubit extends Cubit<LessonsState> {
  final GetLessonsUsecase getLessonsUsecase;

  LessonsCubit(this.getLessonsUsecase) : super(LessonsInitial());

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
