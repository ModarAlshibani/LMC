import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/student_features/notes/data/models/note_model.dart';

class AddNoteUsecase {
  final ApiService apiService;

  AddNoteUsecase(this.apiService);

  Future<bool> execute(Notes note) async {
    try {
      return await apiService.addNote(note);
    } catch (e) {
      throw Exception('Error adding note: $e');
    }
  }
}
