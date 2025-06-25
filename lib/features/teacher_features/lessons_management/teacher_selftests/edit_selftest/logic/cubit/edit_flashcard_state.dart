part of 'edit_flashcard_cubit.dart';

abstract class EditFlashcardState extends Equatable {
  const EditFlashcardState();

  @override
  List<Object?> get props => [];
}

class EditFlashcardInitial extends EditFlashcardState {}

class EditFlashcardLoading extends EditFlashcardState {}

class EditFlashcardSuccess extends EditFlashcardState {}

class EditFlashcardFailure extends EditFlashcardState {
  final String error;

  const EditFlashcardFailure(this.error);

  @override
  List<Object?> get props => [error];
}