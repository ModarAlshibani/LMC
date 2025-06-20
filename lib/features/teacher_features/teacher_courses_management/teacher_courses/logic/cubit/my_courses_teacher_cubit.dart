import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/for_all/available_courses/data/models/available_courses_model.dart';
import 'package:lmc_app/features/for_all/available_courses/logic/usecases/available_courses_usecase.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/data/model/my_courses_teacher_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/logic/usecases/my_courses_teacher_usecase.dart';


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
