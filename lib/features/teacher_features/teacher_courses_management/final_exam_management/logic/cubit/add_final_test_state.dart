part of 'add_final_test_cubit.dart';

abstract class AddFinalTestState extends Equatable {
  const AddFinalTestState();

  @override
  List<Object?> get props => [];
}

class AddFinalTestInitial extends AddFinalTestState {}

class AddFinalTestLoading extends AddFinalTestState {}

class AddFinalTestSuccess extends AddFinalTestState {}

class AddFinalTestFailure extends AddFinalTestState {
  final String error;

  const AddFinalTestFailure(this.error);

  @override
  List<Object?> get props => [error];
}
