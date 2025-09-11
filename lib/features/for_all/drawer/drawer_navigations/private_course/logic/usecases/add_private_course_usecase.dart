import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/data/private_course_model.dart';

class AddPrivateCourseUsecase {
  final ApiService apiService;

  AddPrivateCourseUsecase(this.apiService);

  Future<bool> execute(Request pc) async {
    try {
      return await apiService.addPC(pc);
    } catch (e) {
      throw Exception('Error adding pc: $e');
    }
  }
}
