// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:lmc_app/features/student_features/notes/data/models/note_model.dart';
import 'package:lmc_app/features/student_features/notes/logic/cubit/note_state.dart';
import 'package:lmc_app/features/student_features/notes/logic/usecases/add_note_usecase.dart';
import 'package:lmc_app/features/student_features/notes/logic/usecases/delete_note_usecase.dart';
import 'package:lmc_app/features/student_features/notes/logic/usecases/edit_note_usecase.dart';
import 'package:lmc_app/features/student_features/notes/logic/usecases/get_note_usecase.dart';


class NotesCubit extends Cubit<NotesState> {
  final GetNotesUsecase getNotesUsecases;
  final AddNoteUsecase addNoteUsecase;
  final UpdateNoteUsecase updateNoteUsecase;


  NotesCubit({
    required this.getNotesUsecases,
    required this.addNoteUsecase,
    required this.deleteNoteUsecase,
    required this.updateNoteUsecase
  }) : super(NotesInitial());

  Future<void> fetchNotes() async {
    emit(NotesLoading());

  try {
      final notes = await getNotesUsecases.execute();
      emit(NotesSuccess(notes));
    } catch (error) {
      emit(NotesFailure(error.toString()));
    }
  }
    
  Future<void> addNote(Notes note) async {
  emit(NotesLoading());

  try {
    final result = await addNoteUsecase.execute(note);
    if (result) {
      fetchNotes(); 
    } else {
      emit(const NotesFailure("Failed to add note."));
    }
  } catch (e) {
    emit(NotesFailure(e.toString()));
  }
}

final DeleteNoteUsecase deleteNoteUsecase; // Add this to constructor

Future<void> deleteNote(int noteId) async {
  emit(NotesLoading());
  try {
    final result = await deleteNoteUsecase.execute(noteId);
    if (result) {
      await fetchNotes(); // Refresh the list after deletion
    } else {
      emit(const NotesFailure("Failed to delete note."));
    }
  } catch (e) {
    emit(NotesFailure(e.toString()));
  }
}

Future<void> editNote(Notes note) async {
  emit(NotesLoading());
  try {
    final result = await updateNoteUsecase.execute(note);
    if (result) {
      await fetchNotes();
    } else {
      emit(const NotesFailure("Failed to update note."));
    }
  } catch (e) {
    emit(NotesFailure(e.toString()));
  }
}



    
}