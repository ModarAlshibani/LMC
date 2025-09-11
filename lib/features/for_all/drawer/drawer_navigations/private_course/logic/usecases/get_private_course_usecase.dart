import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/data/private_course_model.dart';

class GetPrivateCourseUsecase {
  final ApiService apiService;

  GetPrivateCourseUsecase(this.apiService);

  Future<List<Request>> execute() async {
    try {
      final pc = await apiService.getRequests();
      return pc.requests ?? [];
    } catch (e) {
      throw Exception('Error getting notes: $e');
    }
  }
}
