part of 'show_teachers_cubit.dart';

abstract class ShowTeachersState extends Equatable {
  const ShowTeachersState();

  @override
  List<Object?> get props => [];
}

class ShowTeachersInitial extends ShowTeachersState {}

class ShowTeachersLoading extends ShowTeachersState {}

class ShowTeachersSuccess extends ShowTeachersState {
  final List<Teachers> teachers;

  const ShowTeachersSuccess(this.teachers);

  @override
  List<Object?> get props => [teachers];
}

class ShowTeachersFailure extends ShowTeachersState {
  final String error;

  const ShowTeachersFailure(this.error);

  @override
  List<Object?> get props => [error];
}
