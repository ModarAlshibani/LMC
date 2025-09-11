
part of 'my_complaints_cubit.dart';

abstract class MyComplaintsState extends Equatable {
  const MyComplaintsState();

  @override
  List<Object?> get props => [];
}

class MyComplaintsInitial extends MyComplaintsState {}

class MyComplaintsLoading extends MyComplaintsState {}

class MyComplaintsSuccess extends MyComplaintsState {
  final List<Data> myComplaints;

  const MyComplaintsSuccess(this.myComplaints);

  @override
  List<Object?> get props => [myComplaints];
}

class MyComplaintsFailure extends MyComplaintsState {
  final String error;

  const MyComplaintsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
