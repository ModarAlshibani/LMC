part of 'all_tasks_cubit.dart';

abstract class AllTasksState extends Equatable {
  const AllTasksState();

  @override
  List<Object?> get props => [];
}

class AllTasksInitial extends AllTasksState {}

class AllTasksLoading extends AllTasksState {}

class AllTasksSuccess extends AllTasksState {
  final List<AssignedTasks> tasks;

  const AllTasksSuccess(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class AllTasksFailure extends AllTasksState {
  final String error;

  const AllTasksFailure(this.error);

  @override
  List<Object?> get props => [error];
}
