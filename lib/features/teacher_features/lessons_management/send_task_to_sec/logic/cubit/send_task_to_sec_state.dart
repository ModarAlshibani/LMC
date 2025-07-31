part of 'send_task_to_sec_cubit.dart';

abstract class SendTaskToSecState extends Equatable {
  const SendTaskToSecState();

  @override
  List<Object?> get props => [];
}

class SendTaskToSecStateInitial extends SendTaskToSecState {}

class SendTaskToSecStateLoading extends SendTaskToSecState {}

class SendTaskToSecStateSuccess extends SendTaskToSecState {}

class SendTaskToSecStateFailure extends SendTaskToSecState {
  final String error;

  const SendTaskToSecStateFailure(this.error);

  @override
  List<Object?> get props => [error];
}
