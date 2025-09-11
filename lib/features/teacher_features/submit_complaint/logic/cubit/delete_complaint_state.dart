
part of 'delete_complaint_cubit.dart';

abstract class DeleteComplaintState extends Equatable {
  const DeleteComplaintState();

  @override
  List<Object?> get props => [];
}

class DeleteComplaintInitial extends DeleteComplaintState {}

class DeleteComplaintLoading extends DeleteComplaintState {}

class DeleteComplaintSuccess extends DeleteComplaintState {
 

}

class DeleteComplaintFailure extends DeleteComplaintState {
  final String error;

  const DeleteComplaintFailure(this.error);

  @override
  List<Object?> get props => [error];
}
