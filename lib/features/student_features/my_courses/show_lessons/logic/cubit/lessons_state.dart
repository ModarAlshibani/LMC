
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/student_features/my_courses/show_lessons/data/models/lessons_model.dart';

abstract class LessonsState extends Equatable {
  const LessonsState();

  @override
  List<Object?> get props => [];
}

class LessonsInitial extends LessonsState {}

class LessonsLoading extends LessonsState {}

class LessonsSuccess extends LessonsState {
  final List<Lesson> myLessons;

  const LessonsSuccess(this.myLessons);

  @override
  List<Object?> get props => [myLessons];
}

class LessonsFailure extends LessonsState {
  final String error;

  const LessonsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
