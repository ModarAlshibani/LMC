

import 'package:lmc_app/features/for_all/placement_tests/data/repo/placement_test_repository.dart';

class GetNextQuestionUseCase {
  final PlacementTestRepository _repository;

  GetNextQuestionUseCase(this._repository);

  Future<dynamic> call() async {
    try {
      return await _repository.getNextQuestion();
    } catch (e) {
      throw Exception('Failed to get next question: $e');
    }
  }
}