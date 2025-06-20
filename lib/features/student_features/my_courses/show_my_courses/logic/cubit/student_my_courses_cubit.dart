import 'package:bloc/bloc.dart';
import 'student_my_courses_state.dart';
import '../usecases/student_my_courses_usecase.dart';



class StudentMyCoursesCubit extends Cubit<StudentMyCoursesState> {
  final GetStudentMyCoursesUsecase getStudentMyCoursesUsecase;

  StudentMyCoursesCubit(this.getStudentMyCoursesUsecase) : super(StudentMyCoursesInitial());

  Future<void> fetchStudentMyCourses() async {
    emit(StudentMyCoursesLoading());

    try {
      final myCourses = await getStudentMyCoursesUsecase.execute();
      emit(StudentMyCoursesSuccess(myCourses));
    } catch (error) {
      emit(StudentMyCoursesFailure(error.toString()));
    }
  }
}
