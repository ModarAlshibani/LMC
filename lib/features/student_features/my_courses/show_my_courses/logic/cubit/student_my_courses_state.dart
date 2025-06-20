import 'package:equatable/equatable.dart';
import '../../data/models/stu_my_courses_model.dart';

abstract class StudentMyCoursesState extends Equatable {
  const StudentMyCoursesState();

  @override
  List<Object?> get props => [];
}

class StudentMyCoursesInitial extends StudentMyCoursesState {}

class StudentMyCoursesLoading extends StudentMyCoursesState {}

class StudentMyCoursesSuccess extends StudentMyCoursesState {
  final List<MyCoursesStu> myCoursesStu;

  const StudentMyCoursesSuccess(this.myCoursesStu);

  @override
  List<Object?> get props => [myCoursesStu];
}

class StudentMyCoursesFailure extends StudentMyCoursesState {
  final String error;

  const StudentMyCoursesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
