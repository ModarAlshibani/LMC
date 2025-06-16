
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/student_features/my_courses/show_my_courses/data/models/stu_my_courses_model.dart';

abstract class StudentMyCoursesState extends Equatable {
  const StudentMyCoursesState();

  @override
  List<Object?> get props => [];
}

class StudentMyCoursesInitial extends StudentMyCoursesState {}

class StudentMyCoursesLoading extends StudentMyCoursesState {}

class StudentMyCoursesSuccess extends StudentMyCoursesState {
  final List<MyCourses> myCourses;

  const StudentMyCoursesSuccess(this.myCourses);

  @override
  List<Object?> get props => [myCourses];
}

class StudentMyCoursesFailure extends StudentMyCoursesState {
  final String error;

  const StudentMyCoursesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
