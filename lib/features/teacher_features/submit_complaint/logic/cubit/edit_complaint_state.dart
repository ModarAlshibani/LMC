
part of 'edit_complaint_cubit.dart';

abstract class EditComplaintState extends Equatable {
  const EditComplaintState();

  @override
  List<Object?> get props => [];
}

class EditComplaintInitial extends EditComplaintState {}

class EditComplaintLoading extends EditComplaintState {}

class EditComplaintSuccess extends EditComplaintState {
 

}

class EditComplaintFailure extends EditComplaintState {
  final String error;

  const EditComplaintFailure(this.error);

  @override
  List<Object?> get props => [error];
}
