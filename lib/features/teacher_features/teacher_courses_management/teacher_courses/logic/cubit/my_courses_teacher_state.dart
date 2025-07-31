part of 'my_courses_teacher_cubit.dart';

abstract class MyCoursesTeacherState extends Equatable {
  const MyCoursesTeacherState();

  @override
  List<Object?> get props => [];
}

class MyCoursesTeacherInitial extends MyCoursesTeacherState {}

class MyCoursesTeacherLoading extends MyCoursesTeacherState {}

class MyCoursesTeacherSuccess extends MyCoursesTeacherState {
  final List<MyCourses> MyCoursesTeacher;

  const MyCoursesTeacherSuccess(this.MyCoursesTeacher);

  @override
  List<Object?> get props => [MyCoursesTeacher];
}

class MyCoursesTeacherFailure extends MyCoursesTeacherState {
  final String error;

  const MyCoursesTeacherFailure(this.error);

  @override
  List<Object?> get props => [error];
}
