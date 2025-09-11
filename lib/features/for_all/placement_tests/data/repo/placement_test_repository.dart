// lib/features/placement_test/logic/placement_test_repository.dart
import 'package:lmc_app/features/for_all/placement_tests/data/models/placement_test_question_model.dart';
import 'package:lmc_app/features/for_all/placement_tests/data/models/placement_test_resault_model.dart';
import 'placement_test_api.dart';

abstract class PlacementTestRepository {
  Future<dynamic> getNextQuestion();
  Future<bool> submitAnswer({required int questionId, required int? answerId});
}

class PlacementTestRepositoryImpl implements PlacementTestRepository {
  final PlacementTestApi _api;

  PlacementTestRepositoryImpl(this._api);

  @override
  Future<dynamic> getNextQuestion() async {
    try {
      final response = await _api.getNextQuestion();
      
      if (response.data.containsKey('Question')) {
        return QuestionModel.fromJson(response.data['Question']);
      } else if (response.data.containsKey('message') && 
                 response.data['message'] == 'Test Completed') {
        return TestResultModel.fromJson(response.data);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> submitAnswer({
    required int questionId,
    required int? answerId,
  }) async {
    try {
      final response = await _api.submitAnswer(
        questionId: questionId,
        answerId: answerId,
      );
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }
}