import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/my_courses_teacher_model.dart';
import '../usecases/my_courses_teacher_usecase.dart';


part 'my_courses_teacher_state.dart';

class MyCoursesTeacherCubit extends Cubit<MyCoursesTeacherState> {
  final GetMyCoursesTeacherUseCase getMyCoursesTeacherUseCase;

  MyCoursesTeacherCubit(this.getMyCoursesTeacherUseCase) : super(MyCoursesTeacherInitial());

  Future<void> fetchMyCoursesTeacher() async {
    emit(MyCoursesTeacherLoading());

    try {
      final MyCoursesTeacher = await getMyCoursesTeacherUseCase.execute();
      emit(MyCoursesTeacherSuccess(MyCoursesTeacher));
    } catch (error) {
      emit(MyCoursesTeacherFailure(error.toString()));
    }
  }
}
