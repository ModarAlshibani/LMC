import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/login/data/models/login_response.dart';

class GetMyProfileUsecase {
  final ApiService apiService;

  GetMyProfileUsecase(this.apiService);

  Future<User> execute() async {
    try {
      final myInfo = await apiService.getUserName();
      print(myInfo);
      print("objectnhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");

      // Return the list of availableCourses directly
      return myInfo;
    } catch (e) {
      throw Exception('Error getting MyCourses: $e');
    }
  }
}
