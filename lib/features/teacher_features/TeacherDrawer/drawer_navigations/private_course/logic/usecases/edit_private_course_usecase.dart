import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/data/private_course_model.dart';
 

class UpdatePrivateCourseUsecase {
  final ApiService apiService;

  UpdatePrivateCourseUsecase(this.apiService);

  Future<bool> execute(Request pc) async {
    return await apiService.editPC(pc);
  }
}
