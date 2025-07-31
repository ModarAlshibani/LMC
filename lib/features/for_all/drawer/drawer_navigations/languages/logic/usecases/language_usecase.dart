import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/data/model/language_model.dart';

class GetLanguageUsecase {
  final ApiService apiService;

  GetLanguageUsecase(this.apiService);

  Future<LanguageModel> execute() async {
    try {
      final language = await apiService.getAllLanguages();

      return language;
    } catch (e) {
      throw Exception('Error getting Info: $e');
    }
  }
}
