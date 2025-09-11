import 'package:lmc_app/core/networking/api_service.dart';

class DeletePrivateCourseUsecase {
  final ApiService apiService;

  DeletePrivateCourseUsecase(this.apiService);

  Future<bool> execute(int pcId) async {
    try {
      return await apiService.deletePC(pcId);
    } catch (e) {
      throw Exception('Error deleting pc: $e');
    }
  }
}
