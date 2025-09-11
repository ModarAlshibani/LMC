import 'package:lmc_app/core/networking/api_service.dart';

import '../../data/models/all_final_test_questions_model.dart';

class GetAllFinalTestQuestionsUsecase {
  final ApiService apiService;

  GetAllFinalTestQuestionsUsecase(this.apiService);

  Future<List<Questions>> execute(int testId) async {
    try {
      // Call the API service to get all availableCourses
      final questions = await apiService.getAllFinalTestQuestions(testId);
      print(questions);
      print("objectnhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");

      // Return the list of availableCourses directly
      return questions.questions!;
    } catch (e) {
      throw Exception('Error getting MyCourses: $e');
    }
  }
}
