<<<<<<< Updated upstream:lib/features/for_all/announsments/logic/usecases/get_all_announcements_usecase.dart
import 'package:flutter/cupertino.dart';
import 'package:lmc_app/features/for_all/announsments/data/models/all_announsments.dart';
=======
import 'package:lmc_app/features/announsments/data/models/all_announsments.dart';
>>>>>>> Stashed changes:lib/features/announsments/logic/usecases/get_all_announcements_usecase.dart
import 'package:lmc_app/core/networking/api_service.dart';

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
