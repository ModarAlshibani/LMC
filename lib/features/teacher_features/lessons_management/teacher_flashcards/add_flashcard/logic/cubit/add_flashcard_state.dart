part of 'add_flashcard_cubit.dart';

abstract class AddFlashcardState extends Equatable {
  const AddFlashcardState();

  @override
  List<Object?> get props => [];
}

class AddFlashcardInitial extends AddFlashcardState {}

class AddFlashcardLoading extends AddFlashcardState {}

class AddFlashcardSuccess extends AddFlashcardState {}

class AddFlashcardFailure extends AddFlashcardState {
  final String error;

  const AddFlashcardFailure(this.error);

  @override
  List<Object?> get props => [error];
}