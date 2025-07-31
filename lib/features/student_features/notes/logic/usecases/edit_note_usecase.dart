import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/student_features/notes/data/models/note_model.dart';

class UpdateNoteUsecase {
  final ApiService apiService;

  UpdateNoteUsecase(this.apiService);

  Future<bool> execute(Notes note) async {
    return await apiService.editNote(note);
  }
}
