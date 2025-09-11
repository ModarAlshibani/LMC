part of 'show_schedule_cubit.dart';

abstract class ShowScheduleState extends Equatable {
  const ShowScheduleState();

  @override
  List<Object?> get props => [];
}

class ShowScheduleInitial extends ShowScheduleState {}

class ShowScheduleLoading extends ShowScheduleState {}

class ShowScheduleSuccess extends ShowScheduleState {
  final TeacherScheduleModel schedule;

  const ShowScheduleSuccess(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class ShowScheduleFailure extends ShowScheduleState {
  final String error;

  const ShowScheduleFailure(this.error);

  @override
  List<Object?> get props => [error];
}
