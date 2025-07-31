
import 'package:equatable/equatable.dart';
import '../../data/models/tacher_course_lessons_model.dart';


abstract class TeacherLessonsState extends Equatable {
  const TeacherLessonsState();

  @override
  List<Object?> get props => [];
}

class LessonsInitial extends TeacherLessonsState {}

class LessonsLoading extends TeacherLessonsState {}

class LessonsSuccess extends TeacherLessonsState {
  final List<Lessons> myLessons;

  const LessonsSuccess(this.myLessons);

  @override
  List<Object?> get props => [myLessons];
}

class LessonsFailure extends TeacherLessonsState {
  final String error;

  const LessonsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
