import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/data/lang_files_model.dart';

class GetLangFilesUsecase {
  final ApiService apiService;

  GetLangFilesUsecase(this.apiService);

  Future<LangFilesModel> execute(int languageId) async {
    try {
      final langFiles = await apiService.getLangFiles(languageId);
      return langFiles;
    } catch (e) {
      throw Exception('Error getting Info: $e');
    }
  }
}
