import 'package:lmc_app/features/for_all/placement_tests/data/repo/placement_test_repository.dart';
class SubmitAnswerUseCase {
  final PlacementTestRepository _repository;

  SubmitAnswerUseCase(this._repository);

  Future<bool> call({
    required int questionId,
    required int? answerId,
  }) async {
    try {
      return await _repository.submitAnswer(
        questionId: questionId,
        answerId: answerId,
      );
    } catch (e) {
      throw Exception('Failed to submit answer: $e');
    }
  }
}