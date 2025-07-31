part of 'mark_attendance_cubit.dart';

abstract class MarkAttendanceState extends Equatable {
  const MarkAttendanceState();

  @override
  List<Object?> get props => [];
}

class MarkAttendanceInitial extends MarkAttendanceState {}

class MarkAttendanceLoading extends MarkAttendanceState {}

class MarkAttendanceSuccess extends MarkAttendanceState {}

class MarkAttendanceFailure extends MarkAttendanceState {
  final String error;

  const MarkAttendanceFailure(this.error);

  @override
  List<Object?> get props => [error];
}