import '../../data/models/all_announsments.dart';
import '../../../../../core/networking/api_service.dart';

class GetAllAnnouncementsUseCase {
  final ApiService apiService;

  GetAllAnnouncementsUseCase(this.apiService);

  Future<List<Announcements>> execute() async {
    try {
      // Call the API service to get all announcements
      final announcements = await apiService.getAllAnnouncements();
      
      // Return the list of announcements directly
      return announcements;
    } catch (e) {
      throw Exception('Error getting announcements: $e');
    }
  }
}
