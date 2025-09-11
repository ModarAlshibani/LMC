// lib/features/student_features/show_teachers/logic/show_teachers_state.dart
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
  final String message;
  const ShowTeachersFailure(this.message);

  @override
  List<Object?> get props => [message];
}
