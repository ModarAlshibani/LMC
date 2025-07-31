import 'package:lmc_app/core/networking/api_service.dart';

class DeleteNoteUsecase {
  final ApiService apiService;

  DeleteNoteUsecase(this.apiService);

  Future<bool> execute(int noteId) async {
    try {
      return await apiService.deleteNote(noteId);
    } catch (e) {
      throw Exception('Error deleting note: $e');
    }
  }
}
