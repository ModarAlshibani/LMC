import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/data/holidays_model.dart';

class GetHolidaysUsecase {
  final ApiService apiService;

  GetHolidaysUsecase(this.apiService);

  Future<HolidaysModel> execute() async {
    try {
      final holidays = await apiService.getHolidays();

      return holidays;
    } catch (e) {
      throw Exception('Error getting holidays: $e');
    }
  }
}
