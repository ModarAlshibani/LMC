import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/data/model/lmc_info_model.dart';

class GetLmcInfoUsecase {
  final ApiService apiService;

  GetLmcInfoUsecase(this.apiService);

  Future<LmcInfoModel> execute() async {
    try {
      final lmcInfo = await apiService.getLmcInfo();

      return lmcInfo;
    } catch (e) {
      throw Exception('Error getting Info: $e');
    }
  }
}
