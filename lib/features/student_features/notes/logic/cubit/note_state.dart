
import 'package:equatable/equatable.dart';
import 'package:lmc_app/features/student_features/notes/data/models/note_model.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesSuccess extends NotesState {
  final List<Notes> notes;

  const NotesSuccess(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NotesFailure extends NotesState {
  final String error;

  const NotesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
