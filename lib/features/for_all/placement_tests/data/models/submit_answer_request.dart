class SubmitAnswerRequest {
  final int questionId;
  final int answerId;

  SubmitAnswerRequest({
    required this.questionId,
    required this.answerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'answer_id': answerId,
    };
  }

  @override
  String toString() => 'SubmitAnswerRequest{questionId: $questionId, answerId: $answerId}';
}