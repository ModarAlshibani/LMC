import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/data/languages_have_library_model.dart';

class GetLanguagesHaveLibraryUsecase {
  final ApiService apiService;

  GetLanguagesHaveLibraryUsecase(this.apiService);

  Future<LanguagesHaveLibraryModel> execute() async {
    try {
      final languagesHaveLibrary = await apiService.getLanguagesHaveLibrary();

      return languagesHaveLibrary;
    } catch (e) {
      throw Exception('Error getting Info: $e');
    }
  }
}
