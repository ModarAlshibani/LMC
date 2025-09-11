import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/features/for_all/login/data/models/login_response.dart';

class EditMyInfoUsecase {
  final ApiService apiService;
  EditMyInfoUsecase(this.apiService);

  Future<OtherInfo> execute({
    String? description,
    String? photoFilePath,
  }) async {
    try {
      final info = await apiService.editMyInfo(
        description: description,
        photoFilePath: photoFilePath,
      );
      return info;
    } catch (e) {
      throw Exception('Error editing info: $e');
    }
  }
}
