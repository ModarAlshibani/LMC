
part of 'submit_complaint_cubit.dart';

abstract class SubmitComplaintState extends Equatable {
  const SubmitComplaintState();

  @override
  List<Object?> get props => [];
}

class SubmitComplaintInitial extends SubmitComplaintState {}

class SubmitComplaintLoading extends SubmitComplaintState {}

class SubmitComplaintSuccess extends SubmitComplaintState {
 

}

class SubmitComplaintFailure extends SubmitComplaintState {
  final String error;

  const SubmitComplaintFailure(this.error);

  @override
  List<Object?> get props => [error];
}
