import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/student_features/notes/data/models/note_model.dart';

class GetNotesUsecase {
  final ApiService apiService;

  GetNotesUsecase(this.apiService);

  Future<List<Notes>> execute() async {
    try {
      final noteModel = await apiService.getNotes();
      return noteModel.notes ?? [];
    } catch (e) {
      throw Exception('Error getting notes: $e');
    }
  }
}
