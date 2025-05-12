part of 'available_courses_cubit.dart';

abstract class AvailableCoursesState extends Equatable {
  const AvailableCoursesState();

  @override
  List<Object?> get props => [];
}

class AvailableCoursesInitial extends AvailableCoursesState {}

class AvailableCoursesLoading extends AvailableCoursesState {}

class AvailableCoursesSuccess extends AvailableCoursesState {
  final List<AvailableCourses> availableCourses;

  const AvailableCoursesSuccess(this.availableCourses);

  @override
  List<Object?> get props => [availableCourses];
}

class AvailableCoursesFailure extends AvailableCoursesState {
  final String error;

  const AvailableCoursesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
