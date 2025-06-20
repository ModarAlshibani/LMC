import 'package:bloc/bloc.dart';
import 'lessons_state.dart';
import '../usecases/lessons_usescase.dart';



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
